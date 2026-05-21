import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    const res = await conn.execute(`SELECT MaChienDich FROM BanDieuHanh b JOIN TaiKhoan t ON b.MaTaiKhoan = t.MaTaiKhoan WHERE t.HoTen = 'Tran Hoai Nam'`);
    console.log("Nam's campaigns:", res.rows);
    if(res.rows.length > 0) {
       const cd = res.rows[0][0];
       const vols = await conn.execute(`SELECT * FROM ThamGiaTNV WHERE MaChienDich = '${cd}'`);
       console.log(`Vols for ${cd}:`, vols.rows);
    }
  } finally {
    await conn.close();
  }
}

test();
