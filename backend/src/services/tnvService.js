import { getConnection } from '../db.js';
import oracledb from 'oracledb';

export const getDashboardSummary = async (username) => {
  let conn;
  try {
    conn = await getConnection();

    // 1. Lấy MaTaiKhoan từ username
    const userSql = `SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = :1`;
    const userRes = await conn.execute(userSql, [username], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    if (userRes.rows.length === 0) throw new Error('Không tìm thấy user.');
    const maTaiKhoan = userRes.rows[0].MATAIKHOAN || userRes.rows[0].MaTaiKhoan;

    // 2. Lấy ThongBao
    const notifSql = `
      SELECT MaThongBao, TieuDe, NoiDung, NgayGui
      FROM ThongBao
      WHERE MaTaiKhoan = :1 AND TrangThai = 'ChuaDoc'
      ORDER BY NgayGui DESC
    `;
    const notifRes = await conn.execute(notifSql, [maTaiKhoan], { outFormat: oracledb.OUT_FORMAT_OBJECT });

    // 3. Lấy Danh sách Chiến dịch Đang tham gia, Tên BDH, và Vai trò
    const campaignSql = `
      SELECT 
          c.MaChienDich, 
          c.TenChienDich, 
          c.NgayBatDau,
          c.NgayKetThuc,
          c.TrangThai,
          hsBDH.HoTen AS NguoiDieuHanh,
          NVL((
              SELECT LISTAGG(pc.VaiTroCuThe, ', ') WITHIN GROUP (ORDER BY pc.MaPhanCong)
              FROM ThamGiaTNV tg2
              JOIN PhanCong pc ON tg2.MaThamGia = pc.MaThamGia
              WHERE tg2.MaTaiKhoan = tg.MaTaiKhoan AND tg2.MaChienDich = c.MaChienDich
          ), 'Tình nguyện viên') AS VaiTroCuaBan
      FROM ThamGiaTNV tg
      JOIN ChienDich c ON tg.MaChienDich = c.MaChienDich
      LEFT JOIN BanDieuHanh bdh ON c.MaChienDich = bdh.MaChienDich
      LEFT JOIN HoSoSinhVien hsBDH ON bdh.MaTaiKhoan = hsBDH.MaTaiKhoan
      WHERE tg.MaTaiKhoan = :1
        AND c.TrangThai IN ('DangHoatDong', 'ChoDuyet', 'DaKetThuc')
    `;
    const campaignRes = await conn.execute(campaignSql, [maTaiKhoan], { outFormat: oracledb.OUT_FORMAT_OBJECT });

    // 4. Lấy dữ liệu Điểm danh (ngày hoạt động cho Calendar)
    const diemdanhSql = `
      SELECT 
          c.MaChienDich, 
          c.TenChienDich, 
          TO_CHAR(dd.NgayDiemDanh, 'YYYY-MM-DD') AS NgayHoatDong
      FROM DiemDanh dd
      JOIN ThamGiaTNV tg ON dd.MaThamGia = tg.MaThamGia
      JOIN ChienDich c ON tg.MaChienDich = c.MaChienDich
      WHERE tg.MaTaiKhoan = :1
    `;
    const diemdanhRes = await conn.execute(diemdanhSql, [maTaiKhoan], { outFormat: oracledb.OUT_FORMAT_OBJECT });

    // 5. Lấy dữ liệu Sự Kiện Cá Nhân
    const eventSql = `
      SELECT MaSuKien, TieuDe, TO_CHAR(ThoiGian, 'YYYY-MM-DD') AS ThoiGian, GhiChu
      FROM SuKienCaNhan
      WHERE MaTaiKhoan = :1
      ORDER BY ThoiGian ASC
    `;
    const eventRes = await conn.execute(eventSql, [maTaiKhoan], { outFormat: oracledb.OUT_FORMAT_OBJECT });

    return {
      notifications: notifRes.rows.map(r => ({
        id: r.MATHONGBAO,
        title: r.TIEUDE,
        content: r.NOIDUNG,
        date: r.NGAYGUI
      })),
      activeCampaigns: campaignRes.rows
        .filter(r => r.TRANGTHAI !== 'DaKetThuc')
        .map(r => ({
          id: r.MACHIENDICH,
          name: r.TENCHIENDICH,
          coordinator: r.NGUOIDIEUHANH || 'Chưa phân công',
          role: r.VAITROCUDABAN || r.VAITROCUABAN,
          startDate: r.NGAYBATDAU,
          endDate: r.NGAYKETTHUC,
          status: r.TRANGTHAI
        })),
      pastCampaigns: campaignRes.rows
        .filter(r => r.TRANGTHAI === 'DaKetThuc')
        .map(r => ({
          id: r.MACHIENDICH,
          name: r.TENCHIENDICH,
          coordinator: r.NGUOIDIEUHANH || 'Chưa phân công',
          role: r.VAITROCUDABAN || r.VAITROCUABAN,
          startDate: r.NGAYBATDAU,
          endDate: r.NGAYKETTHUC,
          status: r.TRANGTHAI
        })),
      attendanceDates: diemdanhRes.rows.map(r => ({
        campaignId: r.MACHIENDICH,
        campaignName: r.TENCHIENDICH,
        date: r.NGAYHOATDONG
      })),
      personalEvents: eventRes.rows.map(r => ({
        id: r.MASUKIEN,
        title: r.TIEUDE,
        date: r.THOIGIAN,
        notes: r.GHICHU
      }))
    };

  } finally {
    if (conn) {
      try { await conn.close(); } catch (e) { console.error(e); }
    }
  }
};

export const addPersonalEvent = async (username, eventData) => {
  let conn;
  try {
    conn = await getConnection();

    const userSql = `SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = :1`;
    const userRes = await conn.execute(userSql, [username], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    if (userRes.rows.length === 0) throw new Error('Không tìm thấy user.');
    const maTaiKhoan = userRes.rows[0].MATAIKHOAN || userRes.rows[0].MaTaiKhoan;

    const sql = `
      INSERT INTO SuKienCaNhan (MaTaiKhoan, TieuDe, ThoiGian, GhiChu)
      VALUES (:1, :2, TO_DATE(:3, 'YYYY-MM-DD'), :4)
    `;
    await conn.execute(sql, [maTaiKhoan, eventData.title, eventData.date, eventData.notes || ''], { autoCommit: true });

    return true;
  } finally {
    if (conn) {
      try { await conn.close(); } catch (e) { console.error(e); }
    }
  }
};

export const getCampaignDetailsForTNV = async (username, campaignId) => {
  let conn;
  try {
    conn = await getConnection();

    // 1. Get User ID
    const userSql = `SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = :1`;
    const userRes = await conn.execute(userSql, [username], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    if (userRes.rows.length === 0) throw new Error('Không tìm thấy user.');
    const maTaiKhoan = userRes.rows[0].MATAIKHOAN || userRes.rows[0].MaTaiKhoan;

    // 2. Get Campaign Info
    const cdSql = `
      SELECT TenChienDich, DiaDiem, TO_CHAR(NgayBatDau, 'YYYY-MM-DD') AS NgayBatDau, TO_CHAR(NgayKetThuc, 'YYYY-MM-DD') AS NgayKetThuc, TrangThai
      FROM ChienDich WHERE MaChienDich = :1
    `;
    const cdRes = await conn.execute(cdSql, [campaignId], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    if (cdRes.rows.length === 0) throw new Error('Không tìm thấy chiến dịch.');
    const campaign = cdRes.rows[0];

    // 3. Get MaThamGia for this user in this campaign (Include both active and completed status)
    const tgSql = `SELECT MaThamGia FROM ThamGiaTNV WHERE MaTaiKhoan = :1 AND MaChienDich = :2 AND TrangThaiDuyet IN ('DaDuyet', 'HoanThanh')`;
    const tgRes = await conn.execute(tgSql, [maTaiKhoan, campaignId], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    const maThamGia = tgRes.rows.length > 0 ? (tgRes.rows[0].MATHAMGIA || tgRes.rows[0].MaThamGia) : null;

    // 4. Get ALL CongViec for this campaign (so the calendar isn't empty)
    const cvSql = `
      SELECT cv.MaCongViec, cv.TenCongViec, 
             DBMS_LOB.SUBSTR(cv.MoTa, 4000, 1) AS MoTa, 
             cv.ThoiGianBatDau, cv.ThoiGianKetThuc, cv.SoLuongTNVCan,
             (SELECT COUNT(*) FROM PhanCong pc2 WHERE pc2.MaCongViec = cv.MaCongViec) as DaPhanCong
      FROM CongViec cv
      WHERE cv.MaChienDich = :1
      ORDER BY cv.ThoiGianBatDau ASC
    `;
    const cvRes = await conn.execute(cvSql, [campaignId], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    const cvRows = cvRes.rows;

    // 4. Get Cumulative Hours for THIS campaign (Task-based logic)
    const hoursSql = `
      SELECT NVL(SUM((cv.ThoiGianKetThuc - cv.ThoiGianBatDau) * 24), 0) AS TongGio
      FROM PhanCong pc
      JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
      WHERE pc.MaThamGia = :1 AND pc.TrangThai != 'HuyBo'
    `;
    const hoursRes = await conn.execute(hoursSql, [maThamGia], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    const tongGio = hoursRes.rows[0].TONGGIO || 0;

    const thamSoSql = `SELECT TenThamSo, GiaTri FROM ThamSo WHERE TenThamSo IN ('GIO_XUAT_SAC', 'GIO_TOT', 'GIO_KHA')`;
    const thamSoRes = await conn.execute(thamSoSql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    const thresholds = {
      GIO_KHA: 0,
      GIO_TOT: 0,
      GIO_XUAT_SAC: 0
    };
    thamSoRes.rows.forEach(r => {
      thresholds[r.TENTHAMSO] = parseInt(r.GIATRI, 10);
    });

    // 5. Get TinTuc & BinhLuan
    const tintucSql = `
      SELECT t.MaTinTuc, t.TieuDe, t.NoiDung, TO_CHAR(t.NgayDang, 'YYYY-MM-DD HH24:MI') AS NgayDang, hs.HoTen AS NguoiDang
      FROM TinTuc t
      JOIN TaiKhoan tk ON t.MaNguoiDang = tk.MaTaiKhoan
      LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
      WHERE t.MaChienDich = :1
      ORDER BY t.NgayDang DESC
    `;
    const tintucRes = await conn.execute(tintucSql, [campaignId], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    
    // We fetch comments for all these news articles
    let newsList = tintucRes.rows.map(r => ({
      id: r.MATINTUC,
      title: r.TIEUDE,
      content: r.NOIDUNG,
      date: r.NGAYDANG,
      author: r.NGUOIDANG || 'Unknown',
      comments: []
    }));

    if (newsList.length > 0) {
      const newsIds = newsList.map(n => n.id);
      const blSql = `
        SELECT b.MaTinTuc, b.NoiDung, TO_CHAR(b.ThoiGian, 'YYYY-MM-DD HH24:MI') AS ThoiGian, hs.HoTen AS NguoiBinhLuan
        FROM BinhLuan b
        JOIN TaiKhoan tk ON b.MaTaiKhoan = tk.MaTaiKhoan
        LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
        WHERE b.MaTinTuc IN (${newsIds.map((_, i) => `:${i+1}`).join(',')})
        ORDER BY b.ThoiGian ASC
      `;
      const blRes = await conn.execute(blSql, newsIds);
      blRes.rows.forEach(r => {
        const newsItem = newsList.find(n => n.id === r.MATINTUC);
        if (newsItem) {
          newsItem.comments.push({
            author: r.NGUOIBINHLUAN || 'Unknown',
            content: r.NOIDUNG,
            date: r.THOIGIAN
          });
        }
      });
    }

    return {
      campaign: {
        id: campaignId,
        name: campaign.TENCHIENDICH,
        TenChienDich: campaign.TENCHIENDICH,
        location: campaign.DIADIEM,
        NgayBatDau: campaign.NGAYBATDAU,
        NgayKetThuc: campaign.NGAYKETTHUC,
        status: campaign.TRANGTHAI
      },
      maThamGia: maThamGia,
      tasks: cvRows.map(r => {
        let desc = r.MOTA || '';
        let endDate = null;
        try {
          if (desc.startsWith('{')) {
            const parsed = JSON.parse(desc);
            desc = parsed.desc;
            endDate = parsed.endDate;
          }
        } catch(e) {}
        return {
          MaCongViec: r.MACONGVIEC,
          TenCongViec: r.TENCONGVIEC,
          MoTa: desc,
          ThoiGianBatDau: r.THOIGIANBATDAU,
          ThoiGianKetThuc: r.THOIGIANKETTHUC || endDate,
          SoLuongTNVCan: r.SOLUONGTNVCAN,
          DaPhanCong: r.DAPHANCONG || 0
        };
      }),
      progress: {
        currentHours: tongGio,
        thresholds
      },
      news: newsList
    };

  } finally {
    if (conn) {
      try { await conn.close(); } catch (e) { console.error(e); }
    }
  }
};
