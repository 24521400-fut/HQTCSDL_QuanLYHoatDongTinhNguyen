import { getConnection } from '../db.js';
import oracledb from 'oracledb';

export async function getInventory(maCD) {
  let connection;
  try {
    connection = await getConnection();
    const query = maCD 
      ? `SELECT lvp.MaLoai AS MALOAI, lvp.TenLoai AS TENLOAI, lvp.DonViTinh AS DONVITINH, 
                NVL(kcd.SoLuongTon, 0) AS SOLUONGTON
         FROM LoaiVatPham lvp
         LEFT JOIN KhoChienDich kcd ON lvp.MaLoai = kcd.MaLoai AND UPPER(TRIM(kcd.MaChienDich)) = UPPER(TRIM(:maCD))
         ORDER BY lvp.TenLoai ASC`
      : `SELECT MaLoai AS MALOAI, TenLoai AS TENLOAI, DonViTinh AS DONVITINH, SoLuongTon AS SOLUONGTON
         FROM LoaiVatPham
         ORDER BY TenLoai ASC`;

    const result = await connection.execute(query, maCD ? { maCD } : [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
    return result.rows;
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}

export async function stockIn(maCD, maLoai, soLuong) {
  let connection;
  try {
    connection = await getConnection();
    
    // Check if exists in KhoChienDich using robust comparison
    const checkRes = await connection.execute(
      `SELECT COUNT(*) AS CNT FROM KhoChienDich 
       WHERE UPPER(TRIM(MaChienDich)) = UPPER(TRIM(:maCD)) AND UPPER(TRIM(MaLoai)) = UPPER(TRIM(:maLoai))`,
      { maCD, maLoai },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    const count = checkRes.rows[0].CNT || checkRes.rows[0].cnt || 0;

    if (count > 0) {
      await connection.execute(
        `UPDATE KhoChienDich SET SoLuongTon = SoLuongTon + :qty 
         WHERE UPPER(TRIM(MaChienDich)) = UPPER(TRIM(:maCD)) AND UPPER(TRIM(MaLoai)) = UPPER(TRIM(:maLoai))`,
        { qty: soLuong, maCD, maLoai }
      );
    } else {
      await connection.execute(
        `INSERT INTO KhoChienDich (MaChienDich, MaLoai, SoLuongTon) 
         VALUES (UPPER(TRIM(:maCD)), UPPER(TRIM(:maLoai)), :qty)`,
        { maCD, maLoai, qty: soLuong }
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

export async function stockOut(maCD, maLoai, soLuong, nguoiNhan) {
  let connection;
  try {
    connection = await getConnection();
    
    // 1. Kiểm tra tồn kho trong KhoChienDich
    const tonKhoResult = await connection.execute(
      `SELECT kcd.SoLuongTon, lvp.TenLoai 
       FROM KhoChienDich kcd
       JOIN LoaiVatPham lvp ON kcd.MaLoai = lvp.MaLoai
       WHERE kcd.MaChienDich = :maCD AND kcd.MaLoai = :maLoai`,
      { maCD, maLoai },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    if (tonKhoResult.rows.length === 0) {
      throw new Error('Vật phẩm không tồn tại trong kho chiến dịch này.');
    }
    
    const tonKho = tonKhoResult.rows[0].SOLUONGTON;
    const tenLoai = tonKhoResult.rows[0].TENLOAI;
    
    if (soLuong > tonKho) {
      throw new Error(`Kho chiến dịch không đủ vật phẩm '${tenLoai}'. Hiện chỉ còn ${tonKho}.`);
    }
    
    // 2. Thực hiện xuất kho
    await connection.execute(
      `UPDATE KhoChienDich SET SoLuongTon = SoLuongTon - :qty WHERE MaChienDich = :maCD AND MaLoai = :maLoai`,
      { qty: soLuong, maCD, maLoai }
    );

    // 3. Log into PhieuXuat
    const res = await connection.execute(
      `INSERT INTO PhieuXuatVatPham (MaChienDich, NgayXuat, NguoiXuat, NguoiNhan)
       VALUES (:maCD, SYSDATE, 'Admin', :nguoiNhan)
       RETURNING MaPhieuXuat INTO :maPhieu`,
      { 
        maCD, 
        nguoiNhan,
        maPhieu: { type: oracledb.STRING, dir: oracledb.BIND_OUT }
      }
    );
    const maPhieu = res.outBinds.maPhieu[0];
    await connection.execute(
      `INSERT INTO ChiTietXuatVP (MaPhieuXuat, MaLoai, SoLuong) VALUES (:maPhieu, :maLoai, :qty)`,
      { maPhieu, maLoai, qty: soLuong }
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

export async function getCampaignLogistics(maCD) {
  let connection;
  try {
    connection = await getConnection();
    
    const imports = await connection.execute(
      `SELECT 
        p.MaPhieuQG as "MaPhieu", 
        p.NgayTiepNhan as "Ngay", 
        'Nhap' as "LoaiPhieu", 
        c.SoLuong as "SoLuong", 
        l.TenLoai as "TenLoai"
       FROM PhieuQuyenGopVP p
       LEFT JOIN ChiTietQuyenGopVP c ON p.MaPhieuQG = c.MaPhieuQG
       LEFT JOIN LoaiVatPham l ON c.MaLoai = l.MaLoai
       WHERE UPPER(TRIM(p.MaChienDich)) = UPPER(TRIM(:maCD))
       ORDER BY p.NgayTiepNhan DESC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    const exports = await connection.execute(
      `SELECT 
        p.MaPhieuXuat as "MaPhieu", 
        p.NgayXuat as "Ngay", 
        c.SoLuong as "SoLuong", 
        l.TenLoai as "TenLoai", 
        p.NguoiNhan as "NguoiNhan"
       FROM PhieuXuatVatPham p
       LEFT JOIN ChiTietXuatVP c ON TRIM(p.MaPhieuXuat) = TRIM(c.MaPhieuXuat)
       LEFT JOIN LoaiVatPham l ON c.MaLoai = l.MaLoai
       WHERE UPPER(TRIM(p.MaChienDich)) = UPPER(TRIM(:maCD))
       ORDER BY p.NgayXuat DESC`,
      { maCD },
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    
    return {
      imports: imports.rows || [],
      exports: exports.rows || []
    };
  } catch (error) {
    throw error;
  } finally {
    if (connection) await connection.close();
  }
}
