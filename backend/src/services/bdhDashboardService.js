import { getConnection } from '../db.js';
import oracledb from 'oracledb';

export async function getBDHContext(maTK) {
  let connection;
  try {
    connection = await getConnection();
    
    const bdhResult = await connection.execute(
      `SELECT MaChienDich FROM BanDieuHanh WHERE MaTaiKhoan = :maTK`,
      { maTK },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (bdhResult.rows.length === 0) {
      return { success: false, message: 'Bạn chưa được phân công quản lý chiến dịch nào.' };
    }
    
    const maCD = bdhResult.rows[0].MACHIENDICH || bdhResult.rows[0].MaChienDich;
    
    const campaignResult = await connection.execute(
      `SELECT c.MaChienDich, c.TenChienDich, c.NgayBatDau, c.NgayKetThuc, c.TrangThai
       FROM ChienDich c WHERE c.MaChienDich = :maCD`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    const budgetResult = await connection.execute(
      `BEGIN :ret := SF_TINH_NGAN_QUY_CD(:p_MaCD); END;`,
      {
        ret: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
        p_MaCD: maCD
      }
    );

    const personnelResult = await connection.execute(
      `SELECT 
        (SELECT COUNT(*) FROM ThamGiaTNV WHERE MaChienDich = :maCD AND TrangThaiDuyet IN ('DaDuyet', 'HoanThanh')) AS Approved,
        SoLuongTNVToiDa AS Target
       FROM ChienDich WHERE MaChienDich = :maCD`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    const inventoryResult = await connection.execute(
      `SELECT MaLoai, TenLoai, DonViTinh, SoLuongTon FROM LoaiVatPham`,
      {},
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    return {
      success: true,
      campaign: campaignResult.rows[0],
      budget: budgetResult.outBinds.ret || 0,
      personnel: personnelResult.rows[0],
      inventory: inventoryResult.rows
    };
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function addGanttTask(maCD, tenCV, moTa, thoiGianBatDau, thoiGianKetThuc, soLuongTNVCan) {
  let connection;
  try {
    connection = await getConnection();
    
    const campaignResult = await connection.execute(
      `SELECT NgayKetThuc FROM ChienDich WHERE MaChienDich = :maCD`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (campaignResult.rows.length === 0) throw new Error('Chiến dịch không tồn tại.');
    
    const campaignEndDate = campaignResult.rows[0].NGAYKETTHUC || campaignResult.rows[0].NgayKetThuc;
    if (campaignEndDate) {
      if (new Date(thoiGianKetThuc) > new Date(campaignEndDate)) {
        throw new Error('Ràng buộc vi phạm: Thời gian kết thúc công việc không được vượt quá thời gian kết thúc chiến dịch.');
      }
    }

    const moTaJson = JSON.stringify({ desc: moTa, endDate: thoiGianKetThuc });
    
    await connection.execute(
      `BEGIN SP_TAO_NHIEMVU_MACDINH(:p_MaCD, :p_TenCV, :p_MaCV_Out); END;`,
      { 
        p_MaCD: maCD, 
        p_TenCV: tenCV,
        p_MaCV_Out: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      }
    );

    const maCV = await connection.execute(
      `SELECT MaCongViec FROM CongViec WHERE MaChienDich = :maCD AND TenCongViec = :tenCV ORDER BY MaCongViec DESC FETCH FIRST 1 ROWS ONLY`,
      { maCD, tenCV },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (maCV.rows.length > 0) {
      const maCongViec = maCV.rows[0].MACONGVIEC || maCV.rows[0].MaCongViec;
      await connection.execute(
        `UPDATE CongViec 
         SET MoTa = :moTaJson, 
             ThoiGianBatDau = TO_DATE(:thoiGianBatDau, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'),
             ThoiGianKetThuc = TO_DATE(:thoiGianKetThuc, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'),
             SoLuongTNVCan = :soLuongTNVCan
         WHERE MaCongViec = :maCongViec`,
        { 
          moTaJson, 
          thoiGianBatDau: new Date(thoiGianBatDau).toISOString().split('.')[0] + 'Z', 
          thoiGianKetThuc: new Date(thoiGianKetThuc).toISOString().split('.')[0] + 'Z', 
          soLuongTNVCan: parseInt(soLuongTNVCan) || 1,
          maCongViec 
        }
      );
    }
    
    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getGanttTasks(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT cv.MaCongViec, cv.TenCongViec, cv.MoTa, cv.ThoiGianBatDau, cv.ThoiGianKetThuc, cv.SoLuongTNVCan,
       (SELECT COUNT(*) FROM PhanCong pc WHERE pc.MaCongViec = cv.MaCongViec) as DaPhanCong
       FROM CongViec cv 
       WHERE cv.MaChienDich = :maCD 
       ORDER BY cv.ThoiGianBatDau ASC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows.map(row => {
      let desc = row.MOTA || row.MoTa || '';
      let endDate = null;
      try {
        if (desc.startsWith('{')) {
          const parsed = JSON.parse(desc);
          desc = parsed.desc;
          endDate = parsed.endDate;
        }
      } catch(e) {}
      
      return {
        MaCongViec: row.MACONGVIEC || row.MaCongViec,
        TenCongViec: row.TENCONGVIEC || row.TenCongViec,
        MoTa: desc,
        ThoiGianBatDau: row.THOIGIANBATDAU || row.ThoiGianBatDau,
        ThoiGianKetThuc: row.THOIGIANKETTHUC || row.ThoiGianKetThuc || endDate,
        SoLuongTNVCan: row.SOLUONGTNVCAN || row.SoLuongTNVCan,
        DaPhanCong: row.DAPHANCONG || row.DaPhanCong || 0
      };
    });
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function verifyProofAndAttend(maThamGia, maMinhChung, trangThai) {
  let connection;
  try {
    connection = await getConnection();
    
    if (trangThai === 'HopLe') {
      const exists = await connection.execute(
        `SELECT MaDiemDanh FROM DiemDanh WHERE MaThamGia = :maThamGia AND TRUNC(NgayDiemDanh) = TRUNC(SYSDATE)`,
        { maThamGia },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      if (exists.rows.length === 0) {
         await connection.execute(
           `INSERT INTO DiemDanh(MaDiemDanh, MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan)
            VALUES ('DD' || LPAD(s_diemdanh_id.NEXTVAL, 8, '0'), :maThamGia, SYSDATE, 'CoMat', 4)`,
           { maThamGia }
         );
      } else {
         const maDD = exists.rows[0].MADIEMDANH || exists.rows[0].MaDiemDanh;
         await connection.execute(
           `UPDATE DiemDanh SET TrangThai = 'CoMat' WHERE MaDiemDanh = :maDD`,
           { maDD }
         );
      }
    }
    
    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function submitDirectExpense(maCD, tenKhoanChi, soTien, mucDich, maNguoiChi, hinhAnhUrl) {
  let connection;
  try {
    connection = await getConnection();
    
    const checkResult = await connection.execute(
      `BEGIN :ret := SF_TINH_NGAN_QUY_CD(:p_MaCD); END;`,
      {
        ret: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
        p_MaCD: maCD
      }
    );
    const remainingBudget = checkResult.outBinds.ret;
    if (soTien > remainingBudget) {
      throw new Error(`Ngân quỹ không đủ. Số dư khả dụng hiện tại là: ${remainingBudget.toLocaleString()} VNĐ`);
    }

    if (!hinhAnhUrl) {
       throw new Error("Bắt buộc phải upload minh chứng (hóa đơn/ảnh thực tế)!");
    }

    await connection.execute(
      `BEGIN SP_THEM_PHIEU_CHI(:p_MaCD, :p_SoTien, :p_MucDich); END;`,
      { p_MaCD: maCD, p_SoTien: soTien, p_MucDich: mucDich }
    );
    
    const ctResult = await connection.execute(
      `SELECT MaChiTieu FROM ChiTieu 
       WHERE MaChienDich = :maCD AND SoTienChi = :soTien 
       ORDER BY MaChiTieu DESC FETCH FIRST 1 ROWS ONLY`,
      { maCD, soTien },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (ctResult.rows.length > 0) {
      const maChiTieu = ctResult.rows[0].MACHITIEU || ctResult.rows[0].MaChiTieu;
      
      const mcResult = await connection.execute(
        `INSERT INTO MinhChungChiTieu(MaMinhChung, HinhAnh_URL, LoaiMinhChung, NgayCapNhat, GhiChu)
         VALUES ('MC' || LPAD(s_minhchungct_id.NEXTVAL, 8, '0'), :hinhAnhUrl, 'HoaDon', SYSDATE, 'Duyet truc tiep boi BDH')
         RETURNING MaMinhChung INTO :maMinhChungOut`,
        { 
          hinhAnhUrl,
          maMinhChungOut: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
        }
      );
      
      const maMinhChung = mcResult.outBinds.maMinhChungOut[0];

      await connection.execute(
        `UPDATE ChiTieu SET TenKhoanChi = :tenKhoanChi, MaNguoiChi = :maNguoiChi, MaMinhChung = :maMinhChung WHERE MaChiTieu = :maChiTieu`,
        { tenKhoanChi, maNguoiChi, maMinhChung, maChiTieu }
      );
    }
    
    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function submitDirectLogistics(maCD, maLoai, soLuong, nguoiNhan, hinhAnhUrl, nguoiXuat) {
  let connection;
  try {
    connection = await getConnection();
    
    if (!hinhAnhUrl) {
       throw new Error("Bắt buộc phải upload ảnh xác nhận/biên nhận khi xuất kho!");
    }

    const result = await connection.execute(
      `INSERT INTO PhieuXuatVatPham(MaPhieuXuat, MaChienDich, NgayXuat, NguoiXuat, NguoiNhan)
       VALUES ('PX' || LPAD(s_phieuxuat_id.NEXTVAL, 8, '0'), :maCD, SYSDATE, :nguoiXuat, :nguoiNhan)
       RETURNING MaPhieuXuat INTO :maPhieuOut`,
      {
        maCD, nguoiXuat, nguoiNhan,
        maPhieuOut: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      }
    );
    
    const maPhieuXuat = result.outBinds.maPhieuOut[0];
    
    await connection.execute(
      `INSERT INTO ChiTietXuatVP(MaPhieuXuat, MaLoai, SoLuong)
       VALUES (:maPhieuXuat, :maLoai, :soLuong)`,
      { maPhieuXuat, maLoai, soLuong }
    );
    
    await connection.execute(
      `UPDATE LoaiVatPham SET SoLuongTon = SoLuongTon - :soLuong WHERE MaLoai = :maLoai`,
      { soLuong, maLoai }
    );

    // Save proof to log
    await connection.execute(
      `INSERT INTO NhatKyHeThong(MaNhatKy, MaTaiKhoan, HanhDong, ThoiGian, ChiTiet)
       VALUES ('NK' || LPAD(s_nhatky_id.NEXTVAL, 8, '0'), :nguoiXuat, 'Xuất kho kèm minh chứng', SYSDATE, :chiTiet)`,
      {
        nguoiXuat,
        chiTiet: `Xuất ${soLuong} vật phẩm (Mã ${maLoai}). Minh chứng: ${hinhAnhUrl}`
      }
    );

    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getRegistrations(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT t.MaThamGia, t.MaChienDich, t.MaTaiKhoan, t.NgayDangKy, t.TrangThaiDuyet,
              h.HoTen, h.MSSV, h.Khoa, h.Lop, h.SoDienThoai
       FROM ThamGiaTNV t
       JOIN HoSoSinhVien h ON t.MaTaiKhoan = h.MaTaiKhoan
       WHERE t.MaChienDich = :maCD AND t.TrangThaiDuyet = 'ChoDuyet'
       ORDER BY t.NgayDangKy DESC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows;
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getEvidenceSubmissions(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT m.MaMinhChung, m.MaThamGia, m.HinhAnh_URL, m.LoaiMinhChung, m.NgayCapNhat,
              h.HoTen, h.MSSV,
              (SELECT COUNT(*) FROM DiemDanh d WHERE d.MaThamGia = m.MaThamGia AND TRUNC(d.NgayDiemDanh) = TRUNC(m.NgayCapNhat)) as IsAttended
       FROM MinhChungTNV m
       JOIN ThamGiaTNV t ON m.MaThamGia = t.MaThamGia
       JOIN HoSoSinhVien h ON t.MaTaiKhoan = h.MaTaiKhoan
       WHERE t.MaChienDich = :maCD
       ORDER BY m.NgayCapNhat DESC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows;
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function bulkApproveEvidence(proofs) {
  let connection;
  try {
    connection = await getConnection();
    for (const p of proofs) {
      const maThamGia = p.MaThamGia;
      const ngayDiemDanh = new Date(p.NgayCapNhat);
      
      const exists = await connection.execute(
        `SELECT MaDiemDanh FROM DiemDanh WHERE MaThamGia = :maThamGia AND TRUNC(NgayDiemDanh) = TRUNC(:ngay)`,
        { maThamGia, ngay: ngayDiemDanh },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      if (exists.rows.length === 0) {
        await connection.execute(
          `INSERT INTO DiemDanh(MaDiemDanh, MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan)
           VALUES ('DD' || LPAD(s_diemdanh_id.NEXTVAL, 8, '0'), :maThamGia, :ngay, 'CoMat', 4)`,
          { maThamGia, ngay: ngayDiemDanh }
        );
      }
    }
    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getCampaignVolunteers(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT t.MaThamGia, h.HoTen, h.MSSV as MaSinhVien, h.MaTaiKhoan, h.Khoa, h.Lop
       FROM ThamGiaTNV t
       JOIN HoSoSinhVien h ON t.MaTaiKhoan = h.MaTaiKhoan
       WHERE t.MaChienDich = :maCD AND t.TrangThaiDuyet = 'DaDuyet'
       ORDER BY h.HoTen ASC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows;
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getTaskById(maCV) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT MaCongViec, MaChienDich, TenCongViec, MoTa, ThoiGianBatDau, SoLuongTNVCan 
       FROM CongViec WHERE MaCongViec = :maCV`,
      { maCV },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    if (result.rows.length === 0) return null;
    
    const row = result.rows[0];
    let desc = row.MOTA || row.MoTa || '';
    let endDate = null;
    try {
      if (desc.startsWith('{')) {
        const parsed = JSON.parse(desc);
        desc = parsed.desc;
        endDate = parsed.endDate;
      }
    } catch(e) {}
    
    return {
      MaCongViec: row.MACONGVIEC || row.MaCongViec,
      MaChienDich: row.MACHIENDICH || row.MaChienDich,
      TenCongViec: row.TENCONGVIEC || row.TenCongViec,
      MoTa: desc,
      ThoiGianBatDau: row.THOIGIANBATDAU || row.ThoiGianBatDau,
      ThoiGianKetThuc: endDate,
      SoLuongTNVCan: row.SOLUONGTNVCAN || row.SoLuongTNVCan
    };
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function updateTaskById(maCV, data) {
  let connection;
  try {
    connection = await getConnection();
    
    const moTaJson = JSON.stringify({ desc: data.MoTa, endDate: data.ThoiGianKetThuc || data.ThoiGianBatDau });
    
    await connection.execute(
      `UPDATE CongViec SET 
        TenCongViec = :ten, 
        MoTa = :moTa, 
        ThoiGianBatDau = TO_DATE(:batDau, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'),
        ThoiGianKetThuc = TO_DATE(:ketThuc, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
       WHERE MaCongViec = :maCV`,
      { 
        ten: data.TenCongViec, 
        moTa: moTaJson, 
        batDau: new Date(data.ThoiGianBatDau).toISOString().split('.')[0] + 'Z', 
        ketThuc: new Date(data.ThoiGianKetThuc || data.ThoiGianBatDau).toISOString().split('.')[0] + 'Z',
        maCV 
      }
    );
    
    await connection.commit();
    return true;
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getNotifications(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT t.MaTinTuc, t.MaChienDich, t.NoiDung, t.NgayDang, hs.HoTen AS NguoiDang
       FROM TinTuc t
       JOIN HoSoSinhVien hs ON t.MaNguoiDang = hs.MaTaiKhoan
       WHERE t.MaChienDich = :maCD
       ORDER BY t.NgayDang DESC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows.map(row => ({
      MaTinTuc: row.MATINTUC || row.MaTinTuc,
      MaChienDich: row.MACHIENDICH || row.MaChienDich,
      NoiDung: row.NOIDUNG || row.NoiDung,
      NgayDang: row.NGAYDANG || row.NgayDang,
      NguoiDang: row.NGUOIDANG || row.NguoiDang
    }));
  } finally {
    if (connection) await connection.close();
  }
}

export async function addNotification(maCD, maTK, noiDung, tieuDe = 'Thông báo mới') {
  let connection;
  try {
    connection = await getConnection();
    
    // 1. Insert into TinTuc (Campaign Bulletin)
    await connection.execute(
      `INSERT INTO TinTuc (MaTinTuc, MaChienDich, MaNguoiDang, NoiDung, TieuDe)
       VALUES ('TT' || LPAD(s_tintuc_id.NEXTVAL, 8, '0'), :maCD, :maTK, :noiDung, :tieuDe)`,
      { maCD, maTK, noiDung, tieuDe }
    );

    // 2. Insert into ThongBao for all participants (Bell alert)
    await connection.execute(
      `INSERT INTO ThongBao (MaThongBao, MaTaiKhoan, TieuDe, NoiDung)
       SELECT 'TB' || LPAD(s_thongbao_id.NEXTVAL, 8, '0'), MaTaiKhoan, :tieuDe, :noiDung
       FROM ThamGiaTNV 
       WHERE MaChienDich = :maCD AND TrangThaiDuyet = 'DaDuyet'`,
      { maCD, tieuDe, noiDung }
    );

    await connection.commit();
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}
export async function getAssignedVolunteers(maCV) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT pc.MaPhanCong, pc.MaThamGia, pc.VaiTroCuThe, pc.TrangThai,
              sv.HoTen, sv.MSSV as MaSinhVien
       FROM PhanCong pc
       JOIN ThamGiaTNV tg ON pc.MaThamGia = tg.MaThamGia
       JOIN HoSoSinhVien sv ON tg.MaTaiKhoan = sv.MaTaiKhoan
       WHERE pc.MaCongViec = :maCV`,
      { maCV },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows;
  } finally {
    if (connection) await connection.close();
  }
}

export async function assignVolunteerToTask(maCV, maTG, vaiTroCuThe, tenNhiemVu) {
  let connection;
  try {
    connection = await getConnection();
    
    // Check capacity
    const capRes = await connection.execute(
      `SELECT SoLuongTNVCan, 
       (SELECT COUNT(*) FROM PhanCong WHERE MaCongViec = :maCV) as DaPhanCong
       FROM CongViec WHERE MaCongViec = :maCV`,
      { maCV },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (capRes.rows.length === 0) throw new Error('Công việc không tồn tại');
    
    const row = capRes.rows[0];
    const soLuongCan = row.SOLUONGTNVCAN || row.SoLuongTNVCan;
    const daPhanCong = row.DAPHANCONG || row.DaPhanCong;
    
    if (daPhanCong >= soLuongCan) {
      throw new Error('Công việc đã đủ số lượng tình nguyện viên phân công!');
    }

    const fullRole = tenNhiemVu ? `${tenNhiemVu} - ${vaiTroCuThe}` : vaiTroCuThe;
    const maPC = 'PC' + Math.floor(Math.random() * 10000000).toString().padStart(8, '0');

    await connection.execute(
      `INSERT INTO PhanCong (MaPhanCong, MaThamGia, MaCongViec, VaiTroCuThe, NgayGiao, TrangThai)
       VALUES (:maPC, :maTG, :maCV, :vaiTro, SYSDATE, 'ChuaBatDau')`,
      { maPC, maTG, maCV, vaiTro: fullRole },
      { autoCommit: true }
    );
    return true;
  } finally {
    if (connection) await connection.close();
  }
}

/**
 * Lấy danh sách đánh giá tình nguyện viên của chiến dịch
 * @param {string} maCD Mã chiến dịch
 */
export async function getEvaluationList(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT 
        tg.MaThamGia, 
        hs.MSSV, 
        hs.HoTen, 
        tg.DiemDanhGia,
        (
          SELECT NVL(SUM((cv.ThoiGianKetThuc - cv.ThoiGianBatDau) * 24), 0)
          FROM PhanCong pc
          JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
          WHERE pc.MaThamGia = tg.MaThamGia
            AND pc.TrangThai != 'HuyBo'
        ) AS TongGio,
        SF_GET_XEP_LOAI(tg.MaThamGia) AS XepLoai
      FROM ThamGiaTNV tg
      JOIN HoSoSinhVien hs ON tg.MaTaiKhoan = hs.MaTaiKhoan
      WHERE tg.MaChienDich = :maCD 
        AND tg.TrangThaiDuyet IN ('DaDuyet', 'HoanThanh')
      ORDER BY hs.HoTen ASC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    // Fetch thresholds
    const paramRes = await connection.execute(
      `SELECT TenThamSo, GiaTri FROM ThamSo WHERE TenThamSo IN ('GIO_XUAT_SAC', 'GIO_TOT', 'GIO_KHA', 'DIEM_XUAT_SAC', 'DIEM_TOT', 'DIEM_KHA')`,
      {},
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    const thresholds = {};
    paramRes.rows.forEach(r => thresholds[r.TENTHAMSO] = parseFloat(r.GIATRI));

    return {
      volunteers: result.rows.map(row => ({
        MaThamGia: row.MATHAMGIA || row.MaThamGia,
        MSSV: row.MSSV,
        HoTen: row.HOTEN || row.HoTen,
        DiemDanhGia: row.DIEMDANHGIA || row.DiemDanhGia,
        TongGio: row.TONGGIO || row.TongGio,
        XepLoai: row.XEPLOAI || row.XepLoai
      })),
      thresholds
    };
  } finally {
    if (connection) await connection.close();
  }
}

/**
 * Phê duyệt đánh giá (Chốt kết quả)
 * @param {string} maThamGia Mã tham gia
 */
export async function approveEvaluation(maThamGia, diem = null) {
  let connection;
  try {
    connection = await getConnection();
    
    // Update DiemDanhGia if provided
    if (diem !== null) {
      await connection.execute(
        `UPDATE ThamGiaTNV SET DiemDanhGia = :diem WHERE MaThamGia = :maTG`,
        { diem, maTG: maThamGia },
        { autoCommit: false }
      );
    }

    // Update status to HoanThanh to trigger TRG_TINHDIEM_THUONG
    await connection.execute(
      `UPDATE ThamGiaTNV SET TrangThaiDuyet = 'HoanThanh' WHERE MaThamGia = :maTG`,
      { maTG: maThamGia },
      { autoCommit: true }
    );

    return { success: true };
  } finally {
    if (connection) await connection.close();
  }
}

/**
 * Từ chối đánh giá kèm minh chứng
 * @param {string} maThamGia Mã tham gia
 * @param {string} lyDo Lý do từ chối
 * @param {string} proofUrl URL minh chứng
 */
export async function rejectEvaluation(maThamGia, lyDo, proofUrl) {
  let connection;
  try {
    connection = await getConnection();
    
    // 1. Cập nhật trạng thái sang Hủy (hoặc TuChoi tùy business)
    await connection.execute(
      `UPDATE ThamGiaTNV SET TrangThaiDuyet = 'Huy' WHERE MaThamGia = :maThamGia`,
      { maThamGia }
    );
    
    // 2. Ghi log từ chối vào bảng mới
    await connection.execute(
      `INSERT INTO RejectionLogs (MaThamGia, LyDo, HinhAnh_URL)
       VALUES (:maThamGia, :lyDo, :proofUrl)`,
      { maThamGia, lyDo, proofUrl }
    );
    
    // 3. Log vào nhật ký hệ thống
    await connection.execute(
      `INSERT INTO NhatKyHeThong (MaNhatKy, MaTaiKhoan, HanhDong, ChiTiet)
       VALUES ('NK' || LPAD(s_nhatky_id.NEXTVAL, 8, '0'), 
               (SELECT MaTaiKhoan FROM ThamGiaTNV WHERE MaThamGia = :maThamGia), 
               'Bị từ chối đánh giá', 
               :chiTiet)`,
      { 
        maThamGia, 
        chiTiet: `Lý do: ${lyDo}. Minh chứng: ${proofUrl}`
      }
    );
    
    await connection.commit();
    return { success: true };
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function getAssignedCampaign(maTK) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT MaChienDich FROM BanDieuHanh WHERE MaTaiKhoan = :maTK`,
      { maTK },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    if (result.rows.length > 0) {
      return result.rows[0].MACHIENDICH || result.rows[0].MaChienDich;
    }
    return null;
  } finally {
    if (connection) await connection.close();
  }
}
