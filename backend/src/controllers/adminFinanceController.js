import express from 'express';
import { 
  getDonationsPendingApproval, 
  getItemDonationsPendingApproval, 
  approveMonetaryDonation, 
  approveItemDonation 
} from '../services/adminFinanceService.js';

const router = express.Router();

router.get('/pending-monetary/:maCD', async (req, res) => {
  try {
    const data = await getDonationsPendingApproval(req.params.maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/pending-items/:maCD', async (req, res) => {
  try {
    const data = await getItemDonationsPendingApproval(req.params.maCD);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/approve-monetary', async (req, res) => {
  try {
    const { id, type } = req.body;
    const result = await approveMonetaryDonation(id, type);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/approve-items', async (req, res) => {
  try {
    const { id } = req.body;
    const result = await approveItemDonation(id);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
