import { getConnection } from '../db.js';
import oracledb from 'oracledb';

export async function getAllPartners() {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `SELECT MaDoiTac, TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi, NguoiDaiDien 
       FROM DoiTac
       ORDER BY TenDoiTac ASC`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    return result.rows;
  } catch (error) {
    throw error;
  } finally {
    if (connection) {
      await connection.close();
    }
  }
}

export async function addPartner(data) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `INSERT INTO DoiTac(MaDoiTac, TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi, NguoiDaiDien)
       VALUES (NULL, :TenDoiTac, :LinhVuc, :SoDienThoai, :Email, :DiaChi, :NguoiDaiDien)
       RETURNING MaDoiTac INTO :MaDoiTac_Out`,
      {
        TenDoiTac: data.tenDoiTac,
        LinhVuc: data.linhVuc || null,
        SoDienThoai: data.soDienThoai || null,
        Email: data.email || null,
        DiaChi: data.diaChi || null,
        NguoiDaiDien: data.nguoiDaiDien || null,
        MaDoiTac_Out: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      }
    );
    await connection.commit();
    return result.outBinds.MaDoiTac_Out[0];
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) {
      await connection.close();
    }
  }
}

export async function recordSponsorship(data) {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute(
      `INSERT INTO TaiTro(MaTaiTro, MaDoiTac, MaChienDich, LoaiTaiTro, GiaTriTaiTro, NgayTaiTro)
       VALUES (NULL, :MaDoiTac, :MaChienDich, :LoaiTaiTro, :GiaTriTaiTro, SYSDATE)
       RETURNING MaTaiTro INTO :MaTaiTro_Out`,
      {
        MaDoiTac: data.maDoiTac,
        MaChienDich: data.maChienDich,
        LoaiTaiTro: data.loaiTaiTro || 'TienMat',
        GiaTriTaiTro: data.giaTriTaiTro,
        MaTaiTro_Out: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      }
    );
    
    // Nếu tài trợ tiền, cộng luôn vào QuyenGopTien để Ban quản lý có thể xem quỹ
    if (data.loaiTaiTro === 'TienMat') {
      const bqlRes = await connection.execute(
        `SELECT MaTaiKhoan FROM TaiKhoan WHERE VaiTro = 'BanQuanLy' FETCH FIRST 1 ROWS ONLY`,
        [],
        { outFormat: oracledb.OUT_FORMAT_OBJECT }
      );
      
      if (bqlRes.rows.length > 0) {
        const adminTk = bqlRes.rows[0].MATAIKHOAN || bqlRes.rows[0].MaTaiKhoan;
        await connection.execute(
          `INSERT INTO QuyenGopTien(MaQuyenGop, MaChienDich, MaTaiKhoan, SoTien, NgayGiaoDich, PhuongThuc)
           VALUES (NULL, :MaChienDich, :MaTaiKhoan, :SoTien, SYSDATE, 'ChuyenKhoan')`,
          {
            MaChienDich: data.maChienDich,
            MaTaiKhoan: adminTk,
            SoTien: data.giaTriTaiTro
          }
        );
      }
    }

    await connection.commit();
    return result.outBinds.MaTaiTro_Out[0];
  } catch (error) {
    if (connection) await connection.rollback();
    throw error;
  } finally {
    if (connection) {
      await connection.close();
    }
  }
}
