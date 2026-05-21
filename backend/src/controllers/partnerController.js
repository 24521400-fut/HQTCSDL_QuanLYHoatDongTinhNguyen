import express from 'express';
import { getAllPartners, addPartner, recordSponsorship } from '../services/partnerService.js';

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const partners = await getAllPartners();
    res.json(partners);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const { tenDoiTac, email } = req.body;
    if (!tenDoiTac || !email) {
      return res.status(400).json({ error: 'Tên đối tác và Email là bắt buộc.' });
    }
    
    const newPartnerId = await addPartner(req.body);
    res.json({ success: true, partnerId: newPartnerId, message: 'Đã thêm đối tác thành công.' });
  } catch (error) {
    let errorMessage = error.message;
    if (errorMessage.includes('ORA-00001')) {
      errorMessage = 'Email đối tác đã tồn tại trong hệ thống.';
    }
    res.status(500).json({ error: errorMessage });
  }
});

router.post('/sponsor', async (req, res) => {
  try {
    const { maDoiTac, maChienDich, giaTriTaiTro } = req.body;
    if (!maDoiTac || !maChienDich || !giaTriTaiTro) {
      return res.status(400).json({ error: 'Thiếu thông tin ký kết tài trợ.' });
    }
    
    const newSponsorId = await recordSponsorship(req.body);
    res.json({ success: true, sponsorId: newSponsorId, message: 'Ký kết tài trợ thành công.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
