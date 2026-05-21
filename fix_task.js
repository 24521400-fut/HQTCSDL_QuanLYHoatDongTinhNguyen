import { getConnection } from './backend/src/db.js';

async function test() {
  const conn = await getConnection();
  try {
    await conn.execute(`UPDATE CongViec SET ThoiGianBatDau = ThoiGianBatDau + 7/24, ThoiGianKetThuc = ThoiGianKetThuc + 7/24 WHERE MaCongViec = 'CV00000206'`);
    await conn.commit();
    console.log('Fixed CV00000206');
  } finally {
    await conn.close();
  }
}

test();
