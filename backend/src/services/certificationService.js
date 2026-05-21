import { executeQuery, getConnection } from '../db.js';
import oracledb from 'oracledb';

export const issueCertificates = async (campaignId) => {
  const sql = `
    BEGIN
      SP_CAP_CHUNGNHAN_CD(:campaignId);
    END;
  `;
  await executeQuery(sql, { campaignId }, true);
  return { success: true };
};

export const issueSingleCertificate = async (maThamGia) => {
  let connection;
  try {
    connection = await getConnection();
    
    // Check if certificate already exists
    const existing = await connection.execute(
      `SELECT MaChungNhan FROM GiayChungNhan WHERE MaThamGia = :maThamGia`,
      { maThamGia },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    if (existing.rows.length > 0) {
      throw new Error('TNV này đã được cấp chứng nhận rồi.');
    }
    
    // Check status is HoanThanh
    const statusCheck = await connection.execute(
      `SELECT TrangThaiDuyet FROM ThamGiaTNV WHERE MaThamGia = :maThamGia`,
      { maThamGia },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    if (statusCheck.rows.length === 0) {
      throw new Error('Không tìm thấy thông tin tham gia.');
    }
    const status = statusCheck.rows[0].TRANGTHAIDUYET || statusCheck.rows[0].TrangThaiDuyet;
    if (status !== 'HoanThanh') {
      throw new Error('TNV chưa hoàn thành đánh giá.');
    }
    
    // Issue certificate using the sequence and SF_GET_XEP_LOAI
    await connection.execute(
      `INSERT INTO GiayChungNhan(MaChungNhan, MaThamGia, NgayCap, XepLoai)
       VALUES (NULL, :maThamGia, SYSDATE, SF_GET_XEP_LOAI(:maThamGia2))`,
      { maThamGia, maThamGia2: maThamGia }
    );
    
    await connection.commit();
    return { success: true };
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
};

export const getEligibleVolunteers = async (campaignId) => {
   const sql = `
    SELECT 
      tg.MaThamGia, 
      hs.HoTen, 
      hs.MSSV, 
      tg.TrangThaiDuyet, 
      SF_GET_XEP_LOAI(tg.MaThamGia) AS XepLoai,
      (
        SELECT NVL(SUM((cv.ThoiGianKetThuc - cv.ThoiGianBatDau) * 24), 0)
        FROM PhanCong pc
        JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
        WHERE pc.MaThamGia = tg.MaThamGia
          AND pc.TrangThai != 'HuyBo'
      ) AS TongGio
    FROM ThamGiaTNV tg
    JOIN TaiKhoan tk ON tg.MaTaiKhoan = tk.MaTaiKhoan
    LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
    WHERE tg.MaChienDich = :campaignId 
      AND tg.TrangThaiDuyet = 'HoanThanh'
      AND NOT EXISTS (SELECT 1 FROM GiayChungNhan g WHERE g.MaThamGia = tg.MaThamGia)
  `;
  const result = await executeQuery(sql, { campaignId });
  return result.rows;
};

export const getCertificatesByCampaign = async (campaignId) => {
  const sql = `
    SELECT 
      g.MaChungNhan, 
      g.MaThamGia, 
      g.NgayCap, 
      g.XepLoai, 
      hs.HoTen, 
      hs.MSSV,
      cd.TenChienDich,
      (
        SELECT NVL(SUM((cv.ThoiGianKetThuc - cv.ThoiGianBatDau) * 24), 0)
        FROM PhanCong pc
        JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
        WHERE pc.MaThamGia = tg.MaThamGia
          AND pc.TrangThai != 'HuyBo'
      ) AS TongGio
    FROM GiayChungNhan g
    JOIN ThamGiaTNV tg ON g.MaThamGia = tg.MaThamGia
    JOIN ChienDich cd ON tg.MaChienDich = cd.MaChienDich
    JOIN TaiKhoan tk ON tg.MaTaiKhoan = tk.MaTaiKhoan
    LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
    WHERE tg.MaChienDich = :campaignId
    ORDER BY g.NgayCap DESC
  `;
  const result = await executeQuery(sql, { campaignId });
  return result.rows;
};

export const getMyCertificates = async (username) => {
  const sql = `
    SELECT 
      g.MaChungNhan, 
      g.NgayCap, 
      g.XepLoai, 
      cd.TenChienDich, 
      cd.NgayBatDau, 
      cd.NgayKetThuc, 
      hs.HoTen, 
      hs.MSSV,
      (
        SELECT NVL(SUM((cv.ThoiGianKetThuc - cv.ThoiGianBatDau) * 24), 0)
        FROM PhanCong pc
        JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
        WHERE pc.MaThamGia = tg.MaThamGia
          AND pc.TrangThai != 'HuyBo'
      ) AS TongGio
    FROM GiayChungNhan g
    JOIN ThamGiaTNV tg ON g.MaThamGia = tg.MaThamGia
    JOIN ChienDich cd ON tg.MaChienDich = cd.MaChienDich
    JOIN TaiKhoan tk ON tg.MaTaiKhoan = tk.MaTaiKhoan
    LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
    WHERE tg.MaTaiKhoan = :username
    ORDER BY g.NgayCap DESC
  `;
  const result = await executeQuery(sql, { username });
  return result.rows;
};
