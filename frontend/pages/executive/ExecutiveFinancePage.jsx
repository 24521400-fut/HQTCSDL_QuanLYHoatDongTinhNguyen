import React, { useState, useEffect } from "react";
import MainLayout from "../../components/layout/MainLayout";
import GlassCard from "../../components/common/GlassCard";
import SystemModal from "../../components/common/SystemModal";
import { getCampaignFinanceSummary, requestExpense, attachExpenseProof } from "../../services/finance";
import { getAssignedCampaign } from "../../services/executive";
import { getCampaigns } from "../../services/campaigns";
import { useAuth } from "../../context/AuthContext";
import "./ExecutiveFinancePage.css";

const ExecutiveFinancePage = () => {
  const { user } = useAuth();
  const [campaignName, setCampaignName] = useState("");
  const [financeData, setFinanceData] = useState({
    remainingBudget: 0,
    totalDonations: 0,
    totalExpenses: 0,
    expensesList: []
  });
  const [loading, setLoading] = useState(true);
  const [modal, setModal] = useState({ isOpen: false, title: "", message: "", type: "info" });
  const [assignedMaCD, setAssignedMaCD] = useState("");
  
  // Form state
  const [form, setForm] = useState({
    tenKhoanChi: "",
    soTien: "",
    mucDich: "",
    hinhAnhUrl: ""
  });

  useEffect(() => {
    if (user?.MaTaiKhoan || user?.maTaiKhoan) {
      fetchInitialData();
    }
  }, [user]);

  const fetchInitialData = async () => {
    try {
      setLoading(true);
      const userId = user?.MaTaiKhoan || user?.maTaiKhoan;
      if (!userId) return;

      // 1. Get assigned campaign for this BDH
      const res = await getAssignedCampaign(userId);
      if (!res || !res.maCD) {
        console.warn("No campaign assigned to this user");
        setLoading(false);
        return;
      }
      const maCD = res.maCD;
      setAssignedMaCD(maCD);

      // 2. Fetch finance and campaign name
      const [fin, camps] = await Promise.all([
        getCampaignFinanceSummary(maCD),
        getCampaigns()
      ]);
      
      if (fin) {
        setFinanceData({
          remainingBudget: fin.remainingBudget || 0,
          totalDonations: fin.totalDonations || 0,
          totalExpenses: fin.totalExpenses || 0,
          expensesList: fin.expensesList || []
        });
      }
      
      if (camps && Array.isArray(camps)) {
        const currentCamp = camps.find(c => (c.MaChienDich || c.MACHIENDICH) === maCD);
        setCampaignName(currentCamp ? (currentCamp.TenChienDich || currentCamp.TENCHIENDICH) : maCD);
      }
    } catch (error) {
      console.error("Error fetching finance data:", error);
    } finally {
      setLoading(false);
    }
  };

  const disbursementRate = (financeData?.totalDonations > 0) 
    ? ((financeData.totalExpenses / financeData.totalDonations) * 100).toFixed(1)
    : 0;

  const formatDate = (dateStr) => {
    if (!dateStr) return "N/A";
    try {
      return new Date(dateStr).toLocaleDateString('vi-VN');
    } catch (e) {
      return "N/A";
    }
  };

  const handleAttachProof = async (maChiTieu) => {
    const proofUrl = prompt("Vui lòng nhập Link ảnh hóa đơn/minh chứng cho khoản chi này:");
    if (!proofUrl) return;

    try {
      setLoading(true);
      await attachExpenseProof(maChiTieu, proofUrl, "HoaDon", "Cập nhật bổ sung bởi BDH");
      setModal({ isOpen: true, title: "Thành công", message: "Đã cập nhật minh chứng chi tiêu.", type: "success" });
      fetchInitialData();
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setForm({ ...form, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!form.tenKhoanChi || !form.soTien) {
      setModal({ isOpen: true, title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin.", type: "error" });
      return;
    }

    try {
      await requestExpense(
        assignedMaCD, 
        form.tenKhoanChi, 
        Number(form.soTien), 
        form.mucDich, 
        user?.MaTaiKhoan || user?.maTaiKhoan, 
        form.hinhAnhUrl || "https://placeholder.com/bill.jpg"
      );
      setModal({ isOpen: true, title: "Thành công", message: "Đã tạo phiếu chi thành công.", type: "success" });
      setForm({ tenKhoanChi: "", soTien: "", mucDich: "", hinhAnhUrl: "" });
      fetchInitialData();
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  return (
    <MainLayout>
      <SystemModal 
        isOpen={modal.isOpen} 
        title={modal.title} 
        message={modal.message} 
        type={modal.type} 
        onClose={() => setModal({ ...modal, isOpen: false })} 
      />

      <div className="exec-finance-container">
        <header className="exec-finance-header">
          <div className="header-left">
            <h1>Tài chính & Ngân quỹ</h1>
            <p>Quản lý dòng tiền và các khoản chi phí của chiến dịch</p>
          </div>
          <div className="current-campaign-badge">
            Chiến dịch: <strong>{campaignName || "Đang tải..."}</strong>
          </div>
        </header>

        {loading ? (
          <div className="loading">Đang tải dữ liệu...</div>
        ) : (
          <div className="exec-finance-content">
            {/* Unified Budget Management Card */}
            <section className="full-width-section">
              <GlassCard title="Quản lý Ngân quỹ">
                <div className="budget-unified-content">
                  <div className="budget-stats-row">
                    <div className="stat-box income">
                      <span className="stat-label">Tổng Quyên Góp</span>
                      <span className="stat-value">{(financeData?.totalDonations || 0).toLocaleString()} VNĐ</span>
                    </div>
                    <div className="stat-box expense">
                      <span className="stat-label">Đã Chi Tiêu</span>
                      <span className="stat-value">{(financeData?.totalExpenses || 0).toLocaleString()} VNĐ</span>
                    </div>
                    <div className="stat-box balance">
                      <span className="stat-label">Số Dư Khả Dụng</span>
                      <span className="stat-value">{(financeData?.remainingBudget || 0).toLocaleString()} VNĐ</span>
                    </div>
                  </div>
                  
                  <div className="disbursement-section">
                    <div className="disbursement-info">
                      <span>Tỷ lệ giải ngân</span>
                      <span className="rate-val">{disbursementRate}%</span>
                    </div>
                    <div className="progress-bar-container">
                      <div className="progress-bar-fill" style={{ width: `${disbursementRate}%` }}></div>
                    </div>
                  </div>
                </div>
              </GlassCard>
            </section>

            <div className="exec-finance-grid">
              <GlassCard title="Tạo Phiếu Chi">
                <form className="expenditure-form" onSubmit={handleSubmit}>
                  <div className="form-group">
                    <label>Tên khoản chi</label>
                    <input 
                      type="text" 
                      name="tenKhoanChi" 
                      value={form.tenKhoanChi} 
                      onChange={handleInputChange} 
                      placeholder="Ví dụ: Mua nước uống, Thuê xe..." 
                    />
                  </div>
                  <div className="form-group">
                    <label>Số tiền (VNĐ)</label>
                    <input 
                      type="number" 
                      name="soTien" 
                      value={form.soTien} 
                      onChange={handleInputChange} 
                      placeholder="0" 
                    />
                  </div>
                  <div className="form-group">
                    <label>Mục đích chi</label>
                    <textarea 
                      name="mucDich" 
                      value={form.mucDich} 
                      onChange={handleInputChange} 
                      placeholder="Giải trình chi tiết mục đích sử dụng..."
                    ></textarea>
                  </div>
                  <button type="submit" className="submit-btn">Xác nhận Chi</button>
                </form>
              </GlassCard>

              <GlassCard title="Lịch Sử Chi Tiêu">
                <div className="expense-history">
                  {financeData?.expensesList && financeData.expensesList.length > 0 ? (
                    <table className="history-table">
                      <thead>
                        <tr>
                          <th>Ngày chi</th>
                          <th>Khoản chi</th>
                          <th>Số tiền</th>
                          <th>Trạng thái</th>
                        </tr>
                      </thead>
                      <tbody>
                        {financeData.expensesList.map(item => (
                          <tr key={item?.MaChiTieu || item?.MACHITIEU || Math.random()}>
                            <td>{formatDate(item?.NgayChi || item?.NGAYCHI)}</td>
                            <td>
                              <div className="expense-name">{item?.TenKhoanChi || item?.TENKHOANCHI}</div>
                              <div className="expense-purpose">{item?.MucDich || item?.MUCDICH}</div>
                            </td>
                            <td className="expense-amt">{(item?.SoTienChi || item?.SOTIENCHI || 0).toLocaleString()}đ</td>
                            <td>
                              {item?.HinhAnh_URL || item?.HINHANH_URL ? (
                                <span className="status-badge success">
                                  <i className="fas fa-check-circle"></i> Đã có HĐ
                                </span>
                              ) : (
                                <div className="proof-action-cell">
                                  <span className="status-badge error">
                                    <i className="fas fa-exclamation-triangle"></i> Thiếu HĐ
                                  </span>
                                  <button 
                                    className="attach-proof-btn"
                                    onClick={() => handleAttachProof(item?.MaChiTieu || item?.MACHITIEU)}
                                  >
                                    Gửi hóa đơn
                                  </button>
                                </div>
                              )}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  ) : (
                    <div className="empty-history">Chưa có khoản chi nào được ghi nhận.</div>
                  )}
                </div>
              </GlassCard>
            </div>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default ExecutiveFinancePage;
