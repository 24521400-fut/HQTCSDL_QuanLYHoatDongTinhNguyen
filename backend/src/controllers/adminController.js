import express from 'express';
import { getAllAccounts, updateAccountStatus, deleteAccount, createAccount } from '../services/adminService.js';

const router = express.Router();

// Create account
router.post('/accounts', async (req, res) => {
  try {
    const result = await createAccount(req.body);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all accounts
router.get('/accounts', async (req, res) => {
  try {
    const data = await getAllAccounts();
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update account status
router.patch('/accounts/:maTK/status', async (req, res) => {
  try {
    const { maTK } = req.params;
    const { status } = req.body;
    if (!['HoatDong', 'Khoa'].includes(status)) {
      return res.status(400).json({ error: 'Trạng thái không hợp lệ.' });
    }
    const result = await updateAccountStatus(maTK, status);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete account
router.delete('/accounts/:maTK', async (req, res) => {
  try {
    const { maTK } = req.params;
    const result = await deleteAccount(maTK);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
