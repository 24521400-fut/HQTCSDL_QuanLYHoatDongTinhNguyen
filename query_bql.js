import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    const res = await conn.execute(`SELECT MaTaiKhoan, TenDangNhap FROM TaiKhoan WHERE VaiTro = 'BanQuanLy'`);
    console.log(res.rows);
  } finally {
    await conn.close();
  }
}

test();
