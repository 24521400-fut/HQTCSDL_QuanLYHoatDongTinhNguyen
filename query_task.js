import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    const res = await conn.execute(`SELECT MaCongViec, TenCongViec, TO_CHAR(ThoiGianBatDau, 'YYYY-MM-DD HH24:MI:SS') as TGBD, TO_CHAR(ThoiGianKetThuc, 'YYYY-MM-DD HH24:MI:SS') as TGKT FROM CongViec ORDER BY MaCongViec DESC FETCH FIRST 5 ROWS ONLY`);
    console.log(res.rows);
  } finally {
    await conn.close();
  }
}

test();
