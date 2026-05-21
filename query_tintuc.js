import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    const res = await conn.execute(`SELECT * FROM TinTuc`);
    console.log("TIN TUC:");
    console.log(res.rows);
    
    const res2 = await conn.execute(`SELECT * FROM ThongBao ORDER BY NgayGui DESC FETCH FIRST 5 ROWS ONLY`);
    console.log("THONG BAO:");
    console.log(res2.rows);
  } finally {
    await conn.close();
  }
}

test();
