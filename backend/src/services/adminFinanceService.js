import oracledb from 'oracledb';
import { getConnection } from '../db.js';

export async function getDonationsPendingApproval(maCD) {
  let connection;
  try {
    connection = await getConnection();
    
    // 1. Get Money Donations (QuyenGopTien + ThanhToan status)
    const moneySql = `
      SELECT qg.MaQuyenGop, qg.SoTien, qg.NgayGiaoDich, qg.PhuongThuc, qg.LoiNhan,
             tt.TrangThaiThanhToan, hs.HoTen
      FROM QuyenGopTien qg
      JOIN ThanhToan tt ON qg.MaQuyenGop = tt.MaQuyenGop
      LEFT JOIN HoSoSinhVien hs ON qg.MaTaiKhoan = hs.MaTaiKhoan
      WHERE qg.MaChienDich = :maCD AND tt.TrangThaiThanhToan = 'DangXuLy'
    `;
    
    // 2. Get Monetary Sponsorships (TaiTro)
    const sponsorshipSql = `
      SELECT tt.MaTaiTro, tt.GiaTriTaiTro, tt.NgayTaiTro, tt.LoaiTaiTro, 
             dt.TenDoiTac, tt.TrangThai
      FROM TaiTro tt
      JOIN DoiTac dt ON tt.MaDoiTac = dt.MaDoiTac
      WHERE tt.MaChienDich = :maCD AND tt.TrangThai = 'ChoDuyet'
    `;

    const moneyRes = await connection.execute(moneySql, { maCD });
    const sponsorshipRes = await connection.execute(sponsorshipSql, { maCD });

    return {
      moneyDonations: moneyRes.rows.map(r => ({
        id: r.MAQUYENGOP,
        amount: r.SOTIEN,
        date: r.NGAYGIAODICH,
        method: r.PHUONGTHUC,
        note: r.LOINHAN,
        status: r.TRANGTHAITHANHTOAN,
        donor: r.HOTEN || 'Ẩn danh',
        type: 'QuyenGop'
      })),
      sponsorships: sponsorshipRes.rows.map(r => ({
        id: r.MATAITRO,
        amount: r.GIATRITAITRO,
        date: r.NGAYTAITRO,
        method: r.LOAITAITRO,
        status: r.TRANGTHAI,
        donor: r.TENDOITAC,
        type: 'TaiTro'
      }))
    };
  } finally {
    if (connection) await connection.close();
  }
}

export async function getItemDonationsPendingApproval(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const sql = `
      SELECT p.MaPhieuQG, p.NgayTiepNhan, p.NguoiNhan, p.TrangThai,
             hs.HoTen,
             ct.MaLoai, ct.SoLuong, ct.TinhTrang,
             lvp.TenLoai, lvp.DonViTinh
      FROM PhieuQuyenGopVP p
      LEFT JOIN HoSoSinhVien hs ON p.MaTaiKhoan = hs.MaTaiKhoan
      JOIN ChiTietQuyenGopVP ct ON p.MaPhieuQG = ct.MaPhieuQG
      JOIN LoaiVatPham lvp ON ct.MaLoai = lvp.MaLoai
      WHERE p.MaChienDich = :maCD AND p.TrangThai = 'ChoDuyet'
    `;
    const res = await connection.execute(sql, { maCD });
    return res.rows.map(r => ({
      id: r.MAPHIEUQG,
      date: r.NGAYTIEPNHAN,
      donor: r.HOTEN || 'Ẩn danh',
      receiver: r.NGUOINHAN,
      maLoai: r.MALOAI,
      itemName: r.TENLOAI,
      quantity: r.SOLUONG,
      unit: r.DONVITINH,
      condition: r.TINHTRANG
    }));
  } finally {
    if (connection) await connection.close();
  }
}

export async function approveMonetaryDonation(id, type) {
  let connection;
  try {
    connection = await getConnection();
    if (type === 'QuyenGop') {
      await connection.execute(
        `UPDATE ThanhToan SET TrangThaiThanhToan = 'ThanhCong', NgayThanhToan = SYSDATE WHERE MaQuyenGop = :id`,
        { id },
        { autoCommit: true }
      );
    } else {
      await connection.execute(
        `UPDATE TaiTro SET TrangThai = 'DaDuyet' WHERE MaTaiTro = :id`,
        { id },
        { autoCommit: true }
      );
    }
    return { success: true };
  } finally {
    if (connection) await connection.close();
  }
}

export async function approveItemDonation(maPhieu) {
  let connection;
  try {
    connection = await getConnection();
    
    // 1. Get details and campaign of the donation
    const detailsRes = await connection.execute(
      `SELECT MaLoai, SoLuong, MaChienDich 
       FROM ChiTietQuyenGopVP ct
       JOIN PhieuQuyenGopVP p ON ct.MaPhieuQG = p.MaPhieuQG
       WHERE ct.MaPhieuQG = :maPhieu`,
      { maPhieu },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (detailsRes.rows.length === 0) throw new Error("Không tìm thấy thông tin phiếu quyên góp");
    
    const maCD = detailsRes.rows[0].MACHIENDICH;

    // 2. Update inventory for each item in KhoChienDich
    for (const item of detailsRes.rows) {
      const checkRes = await connection.execute(
        `SELECT COUNT(*) as CNT FROM KhoChienDich WHERE MaChienDich = :maCD AND MaLoai = :maLoai`,
        { maCD, maLoai: item.MALOAI },
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );

      if (checkRes.rows[0].CNT > 0) {
        await connection.execute(
          `UPDATE KhoChienDich SET SoLuongTon = SoLuongTon + :qty WHERE MaChienDich = :maCD AND MaLoai = :maLoai`,
          { qty: item.SOLUONG, maCD, maLoai: item.MALOAI }
        );
      } else {
        await connection.execute(
          `INSERT INTO KhoChienDich (MaChienDich, MaLoai, SoLuongTon) VALUES (:maCD, :maLoai, :qty)`,
          { maCD, maLoai: item.MALOAI, qty: item.SOLUONG }
        );
      }
    }

    // 3. Update Phieu status
    await connection.execute(
      `UPDATE PhieuQuyenGopVP SET TrangThai = 'DaDuyet' WHERE MaPhieuQG = :maPhieu`,
      { maPhieu },
      { autoCommit: true }
    );

    return { success: true };
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}
