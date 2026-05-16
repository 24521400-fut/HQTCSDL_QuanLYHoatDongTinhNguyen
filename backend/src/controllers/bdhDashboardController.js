import express from 'express';
import { 
  getBDHContext,
  addGanttTask,
  getGanttTasks,
  verifyProofAndAttend,
  submitDirectExpense,
  submitDirectLogistics,
  getRegistrations,
  getEvidenceSubmissions,
  bulkApproveEvidence,
  getCampaignVolunteers,
  getTaskById,
  updateTaskById,
  getNotifications,
  addNotification,
  getAssignedVolunteers,
  assignVolunteerToTask,
  getEvaluationList,
  approveEvaluation,
  rejectEvaluation,
  getAssignedCampaign
} from '../services/bdhDashboardService.js';

const router = express.Router();

router.get('/assigned-campaign/:maTK', async (req, res) => {
  try {
    const maCD = await getAssignedCampaign(req.params.maTK);
    res.json({ maCD });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/context/:maTK', async (req, res) => {
  try {
    const { maTK } = req.params;
    const context = await getBDHContext(maTK);
    res.json(context);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/tasks', async (req, res) => {
  try {
    const { maCD, tenCV, moTa, thoiGianBatDau, thoiGianKetThuc, soLuongTNVCan } = req.body;
    if (!maCD || !tenCV || !thoiGianBatDau || !thoiGianKetThuc) {
      return res.status(400).json({ error: 'Thiếu thông tin công việc.' });
    }
    await addGanttTask(maCD, tenCV, moTa, thoiGianBatDau, thoiGianKetThuc, soLuongTNVCan);
    res.json({ success: true, message: 'Đã tạo công việc thành công.' });
  } catch (error) {
    let errorMessage = error.message;
    if (errorMessage.includes('ORA-')) {
        errorMessage = 'Lỗi CSDL: ' + errorMessage.split('\\n')[0];
    }
    res.status(500).json({ error: errorMessage });
  }
});

router.get('/tasks/:maCD', async (req, res) => {
  try {
    const { maCD } = req.params;
    const tasks = await getGanttTasks(maCD);
    res.json(tasks);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/proof/verify', async (req, res) => {
  try {
    const { maThamGia, maMinhChung, trangThai } = req.body;
    if (!maThamGia || !trangThai) {
      return res.status(400).json({ error: 'Thiếu thông tin xét duyệt minh chứng.' });
    }
    await verifyProofAndAttend(maThamGia, maMinhChung, trangThai);
    res.json({ success: true, message: 'Đã xác thực hoạt động và điểm danh TNV.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/expense', async (req, res) => {
  try {
    const { maCD, tenKhoanChi, soTien, mucDich, maNguoiChi, hinhAnhUrl } = req.body;
    if (!maCD || !soTien || !mucDich || !hinhAnhUrl) {
      return res.status(400).json({ error: 'Thiếu thông tin hoặc chưa tải lên minh chứng.' });
    }
    await submitDirectExpense(maCD, tenKhoanChi, soTien, mucDich, maNguoiChi, hinhAnhUrl);
    res.json({ success: true, message: 'Đã chi ngân quỹ thành công.' });
  } catch (error) {
    let errorMessage = error.message;
    if (errorMessage.includes('ORA-')) {
        errorMessage = 'Lỗi CSDL: ' + errorMessage.split('\\n')[0];
    }
    res.status(500).json({ error: errorMessage });
  }
});

router.post('/logistics', async (req, res) => {
  try {
    const { maCD, maLoai, soLuong, nguoiNhan, hinhAnhUrl, nguoiXuat } = req.body;
    if (!maCD || !maLoai || !soLuong || !nguoiNhan || !hinhAnhUrl) {
      return res.status(400).json({ error: 'Thiếu thông tin hoặc chưa tải lên biên nhận.' });
    }
    await submitDirectLogistics(maCD, maLoai, soLuong, nguoiNhan, hinhAnhUrl, nguoiXuat);
    res.json({ success: true, message: 'Đã xuất kho thành công.' });
  } catch (error) {
    let errorMessage = error.message;
    if (errorMessage.includes('ORA-')) {
        errorMessage = 'Lỗi CSDL: ' + errorMessage.split('\\n')[0];
    }
    res.status(500).json({ error: errorMessage });
  }
});

router.get('/registrations/:maCD', async (req, res) => {
  try {
    const { maCD } = req.params;
    const data = await getRegistrations(maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/evidence/:maCD', async (req, res) => {
  try {
    const { maCD } = req.params;
    const data = await getEvidenceSubmissions(maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/proof/bulk-approve', async (req, res) => {
  try {
    const { proofs } = req.body;
    await bulkApproveEvidence(proofs);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/volunteers/:maCD', async (req, res) => {
  try {
    const { maCD } = req.params;
    const data = await getCampaignVolunteers(maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/task/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const data = await getTaskById(id);
    if (!data) return res.status(404).json({ error: 'Nhiệm vụ không tồn tại.' });
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put('/task/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await updateTaskById(id, req.body);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/notifications/:maCD', async (req, res) => {
  try {
    const data = await getNotifications(req.params.maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/notifications', async (req, res) => {
  try {
    const { maCD, maTK, noiDung, tieuDe } = req.body;
    await addNotification(maCD, maTK, noiDung, tieuDe);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/tasks/:id/assigned', async (req, res) => {
  try {
    const data = await getAssignedVolunteers(req.params.id);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/tasks/assign', async (req, res) => {
  try {
    const { maCV, maTG, vaiTroCuThe, tenNhiemVu } = req.body;
    await assignVolunteerToTask(maCV, maTG, vaiTroCuThe, tenNhiemVu);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Evaluation Routes
router.get('/evaluation/list/:maCD', async (req, res) => {
  try {
    const data = await getEvaluationList(req.params.maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/evaluation/approve', async (req, res) => {
  try {
    const { maThamGia, diem } = req.body;
    const result = await approveEvaluation(maThamGia, diem);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/evaluation/reject', async (req, res) => {
  try {
    const { maThamGia, lyDo, proofUrl } = req.body;
    if (!lyDo || !proofUrl) {
      return res.status(400).json({ error: 'Lý do và minh chứng là bắt buộc.' });
    }
    const result = await rejectEvaluation(maThamGia, lyDo, proofUrl);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
