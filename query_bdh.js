import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    const res = await conn.execute(`
      SELECT b.MaChienDich, h.HoTen 
      FROM BanDieuHanh b 
      JOIN HoSoSinhVien h ON b.MaTaiKhoan = h.MaTaiKhoan 
      WHERE h.HoTen LIKE '%Truong Thi Kim Ngan%' OR h.HoTen LIKE '%Trương Thị Kim Ngân%'
    `);
    console.log("Ban Dieu Hanh info:");
    console.log(res.rows);
  } finally {
    await conn.close();
  }
}

test();
