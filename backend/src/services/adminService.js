import oracledb from 'oracledb';
import { getConnection } from '../db.js';

export async function getAllAccounts() {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT 
        tk.MaTaiKhoan, 
        tk.TenDangNhap, 
        tk.Email, 
        tk.VaiTro, 
        tk.TrangThai,
        hs.HoTen,
        hs.MSSV
      FROM TaiKhoan tk
      LEFT JOIN HoSoSinhVien hs ON tk.MaTaiKhoan = hs.MaTaiKhoan
      ORDER BY tk.MaTaiKhoan DESC`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    return result.rows.map(row => ({
      MaTaiKhoan: row.MATAIKHOAN,
      TenDangNhap: row.TENDANGNHAP,
      Email: row.EMAIL,
      VaiTro: row.VAITRO,
      TrangThai: row.TRANGTHAI,
      HoTen: row.HOTEN,
      MSSV: row.MSSV
    }));
  } finally {
    if (connection) await connection.close();
  }
}

export async function updateAccountStatus(maTK, status) {
  let connection;
  try {
    connection = await getConnection();
    console.log(`Updating account ${maTK} status to ${status}`);
    const result = await connection.execute(
      `UPDATE TaiKhoan SET TrangThai = :status WHERE MaTaiKhoan = :maTK`,
      { status, maTK },
      { autoCommit: true }
    );
    console.log(`Update result:`, result);
    return { success: true };
  } catch (error) {
    console.error(`Error in updateAccountStatus for ${maTK}:`, error);
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function deleteAccount(maTK) {
  let connection;
  try {
    connection = await getConnection();
    console.log(`Deleting account ${maTK} and all related data...`);
    await connection.execute(
      `BEGIN SP_DELETE_ACCOUNT(:maTK); END;`,
      { maTK },
      { autoCommit: true }
    );
    return { success: true };
  } catch (error) {
    console.error(`Error in deleteAccount for ${maTK}:`, error);
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function createAccount(data) {
  let connection;
  try {
    connection = await getConnection();
    const { tenDangNhap, matKhau, email, vaiTro, hoTen, mssv } = data;
    
    // Manual insert since SP_DANGKYTAIKHOAN_TNV is specifically for TNV
    const result = await connection.execute(
      `INSERT INTO TaiKhoan (TenDangNhap, MatKhau, Email, VaiTro, TrangThai)
       VALUES (:tenDangNhap, :matKhau, :email, :vaiTro, 'HoatDong')
       RETURNING MaTaiKhoan INTO :maTK`,
      {
        tenDangNhap,
        matKhau,
        email,
        vaiTro,
        maTK: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      },
      { autoCommit: false }
    );

    const maTK = result.outBinds.maTK[0];

    // Create profile
    await connection.execute(
      `INSERT INTO HoSoSinhVien (MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi)
       VALUES (:maTK, :hoTen, :mssv, SYSDATE, 'Khac', 'N/A', 'N/A', 'N/A', 'N/A')`,
      { maTK, hoTen: hoTen || 'New User', mssv: mssv || 'N/A' },
      { autoCommit: true }
    );

    return { success: true, maTK };
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}
