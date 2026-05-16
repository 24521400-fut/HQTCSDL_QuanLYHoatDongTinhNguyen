import { getConnection } from '../db.js';

export const requireRole = (allowedRole) => {
  return async (req, res, next) => {
    let conn;
    try {
      const username = req.params.username || req.body.username || req.query.username;

      if (!username) {
        return res.status(401).json({ error: 'Không tìm thấy thông tin username trong request.' });
      }

      conn = await getConnection();
      const sql = `SELECT VaiTro FROM TaiKhoan WHERE TenDangNhap = :1`;
      const result = await conn.execute(sql, [username]);

      if (result.rows.length === 0) {
        return res.status(404).json({ error: 'Người dùng không tồn tại.' });
      }

      const userRole = result.rows[0].VAITRO;

      if (userRole !== allowedRole) {
        return res.status(403).json({ error: 'Bạn không có quyền truy cập.' });
      }

      // Attach to req for further use
      req.userRole = userRole;
      next();
    } catch (err) {
      console.error('Error in requireRole middleware:', err);
      res.status(500).json({ error: 'Lỗi xác thực quyền.' });
    } finally {
      if (conn) {
        try { await conn.close(); } catch (e) { console.error(e); }
      }
    }
  };
};
