import express from 'express';
import { requireRole } from '../middlewares/roleMiddleware.js';
import { getDashboardSummary, addPersonalEvent } from '../services/tnvService.js';

const router = express.Router();

// Route: Lấy thông tin tổng quan Dashboard TNV
router.get('/dashboard-summary/:username', requireRole('TinhNguyenVien'), async (req, res) => {
  try {
    const summary = await getDashboardSummary(req.params.username);
    res.json(summary);
  } catch (err) {
    console.error('Error fetching TNV Dashboard summary:', err);
    res.status(500).json({ error: 'Lỗi khi tải dữ liệu Dashboard.' });
  }
});

// Route: Thêm sự kiện cá nhân
router.post('/custom-events/:username', requireRole('TinhNguyenVien'), async (req, res) => {
  try {
    const { title, date, notes } = req.body;
    if (!title || !date) {
      return res.status(400).json({ error: 'Vui lòng cung cấp Tiêu đề và Thời gian.' });
    }

    await addPersonalEvent(req.params.username, { title, date, notes });
    res.json({ message: 'Thêm sự kiện thành công.' });
  } catch (err) {
    console.error('Error adding personal event:', err);
    res.status(500).json({ error: 'Lỗi khi thêm sự kiện cá nhân.' });
  }
});

// Route: Lấy chi tiết chiến dịch cho TNV (Timetable, Progress, TinTuc)
router.get('/campaigns/:id/details/:username', requireRole('TinhNguyenVien'), async (req, res) => {
  try {
    const { id, username } = req.params;
    // We will implement getCampaignDetailsForTNV in tnvService.js
    const { getCampaignDetailsForTNV } = await import('../services/tnvService.js');
    const details = await getCampaignDetailsForTNV(username, id);
    res.json(details);
  } catch (err) {
    console.error('Error fetching campaign details:', err);
    res.status(500).json({ error: err.message || 'Lỗi khi tải chi tiết chiến dịch.' });
  }
});

export default router;
