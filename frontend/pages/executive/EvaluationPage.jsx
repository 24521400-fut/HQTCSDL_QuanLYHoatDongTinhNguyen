import React, { useState, useEffect } from "react";
import MainLayout from "../../components/layout/MainLayout";
import GlassCard from "../../components/common/GlassCard";
import SystemModal from "../../components/common/SystemModal";
import { getManagedCampaigns } from "../../services/campaigns";
import { 
  getEvaluationList, 
  approveEvaluation, 
  rejectEvaluation 
} from "../../services/executive";
import { useAuth } from "../../context/AuthContext";
import "./EvaluationPage.css";

const EvaluationPage = () => {
  const { user } = useAuth();
  const [currentCampaign, setCurrentCampaign] = useState(null);
  const [volunteers, setVolunteers] = useState([]);
  const [localScores, setLocalScores] = useState({});
  const [loading, setLoading] = useState(true);
  const [thresholds, setThresholds] = useState({
    GIO_XUAT_SAC: 30, DIEM_XUAT_SAC: 9,
    GIO_TOT: 20, DIEM_TOT: 8,
    GIO_KHA: 10, DIEM_KHA: 6.5
  });
  
  // Feedback modals
  const [modal, setModal] = useState({ isOpen: false, title: "", message: "", type: "error" });
  
  // Action state
  const [confirmModal, setConfirmModal] = useState({ isOpen: false, volunteer: null });
  const [rejectModal, setRejectModal] = useState({ isOpen: false, volunteer: null, reason: "", proof: null });

  useEffect(() => {
    if (user?.MaTaiKhoan) {
      fetchBDHContext();
    }
  }, [user]);

  const fetchBDHContext = async () => {
    try {
      setLoading(true);
      const managed = await getManagedCampaigns(user.MaTaiKhoan);
      if (managed && managed.length > 0) {
        const campaign = managed[0];
        setCurrentCampaign(campaign);
        await fetchVolunteers(campaign.MaChienDich || campaign.MACHIENDICH);
      }
    } catch (error) {
      console.error(error);
      setModal({ isOpen: true, title: "Lỗi", message: "Không thể tải thông tin chiến dịch.", type: "error" });
    } finally {
      setLoading(false);
    }
  };

  const fetchVolunteers = async (maCD) => {
    try {
      setLoading(true);
      const response = await getEvaluationList(maCD);
      const data = response.volunteers || [];
      if (response.thresholds) {
        setThresholds(response.thresholds);
      }
      
      if (Array.isArray(data)) {
        setVolunteers(data);
        // Initialize local scores
        const initialScores = {};
        data.forEach(v => {
          initialScores[v.MaThamGia] = v.DiemDanhGia || '';
        });
        setLocalScores(initialScores);
      } else {
        console.error("Data is not an array:", data);
        setVolunteers([]);
        setModal({ 
          isOpen: true, 
          title: "Lỗi dữ liệu", 
          message: "Máy chủ trả về dữ liệu không hợp lệ.", 
          type: "error" 
        });
      }
    } catch (error) {
      console.error(error);
      setModal({ isOpen: true, title: "Lỗi kết nối", message: "Không thể kết nối đến máy chủ.", type: "error" });
    } finally {
      setLoading(false);
    }
  };

  const handleApprove = async () => {
    const v = confirmModal.volunteer;
    try {
      const score = localScores[v.MaThamGia];
      await approveEvaluation(v.MaThamGia, score);
      setModal({ isOpen: true, title: "Thành công", message: `Đã duyệt đánh giá cho ${v.HoTen}.`, type: "success" });
      setConfirmModal({ isOpen: false, volunteer: null });
      fetchVolunteers(currentCampaign.MaChienDich || currentCampaign.MACHIENDICH);
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const handleReject = async (e) => {
    e.preventDefault();
    const v = rejectModal.volunteer;
    // For this demonstration, we'll use a fake URL since there's no real upload service
    const fakeProofUrl = `proofs/reject_${v.MaThamGia}_${Date.now()}.jpg`;
    
    try {
      await rejectEvaluation(v.MaThamGia, rejectModal.reason, fakeProofUrl);
      setModal({ isOpen: true, title: "Đã từ chối", message: `Đã từ chối đánh giá của ${v.HoTen}.`, type: "success" });
      setRejectModal({ isOpen: false, volunteer: null, reason: "", proof: null });
      fetchVolunteers(currentCampaign.MaChienDich || currentCampaign.MACHIENDICH);
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const getBadgeClass = (xepLoai) => {
    if (!xepLoai) return "badge-none";
    switch(xepLoai.toLowerCase()) {
      case 'xuatsac':
      case 'xuất sắc': return 'badge-gold';
      case 'tot':
      case 'tốt': return 'badge-green';
      case 'kha':
      case 'khá': return 'badge-orange';
      default: return 'badge-gray';
    }
  };

  const getBadgeName = (xepLoai) => {
    if (!xepLoai) return "Chưa có";
    switch(xepLoai.toLowerCase()) {
      case 'xuatsac': return 'Xuất Sắc';
      case 'tot': return 'Tốt';
      case 'kha': return 'Khá';
      case 'trungbinh': return 'Trung Bình';
      default: return xepLoai;
    }
  }

  const formatHours = (hours) => {
    if (!hours && hours !== 0) return '0h';
    const h = Math.floor(hours);
    const m = Math.round((hours - h) * 60);
    if (m === 0) return `${h}h`;
    return `${h}h ${m}p`;
  };

  const getDynamicXepLoai = (v) => {
    const score = parseFloat(localScores[v.MaThamGia]);
    const hours = v.TongGio || 0;
    
    // If no score entered yet, use DB value
    if (isNaN(score)) return v.XepLoai;

    // Sử dụng thresholds từ DB
    if (score >= thresholds.DIEM_XUAT_SAC && hours >= thresholds.GIO_XUAT_SAC) return 'Xuất Sắc';
    if (score >= thresholds.DIEM_TOT && hours >= thresholds.GIO_TOT) return 'Tốt';
    if (score >= thresholds.DIEM_KHA && hours >= thresholds.GIO_KHA) return 'Khá';
    return 'Trung Bình';
  };

  return (
    <MainLayout>
      <SystemModal isOpen={modal.isOpen} title={modal.title} message={modal.message} type={modal.type} onClose={() => setModal({ ...modal, isOpen: false })} />
      
      {/* Confirmation Modal */}
      {confirmModal.isOpen && (
        <div className="custom-modal-overlay">
          <div className="custom-modal glassmorphism">
            <h2>Xác nhận Phê duyệt</h2>
            <p>Bạn có chắc chắn muốn chốt kết quả đánh giá cho <strong>{confirmModal.volunteer.HoTen}</strong>?</p>
            <div className="confirm-info-block" style={{marginTop: '15px', padding: '15px', background: 'rgba(255,255,255,0.1)', borderRadius: '8px'}}>
                <p>Số giờ tích lũy: <strong>{formatHours(confirmModal.volunteer.TongGio)}</strong></p>
                <p>Điểm số: <strong>{localScores[confirmModal.volunteer.MaThamGia]}</strong></p>
            </div>
            <p className="sub-text" style={{marginTop: '10px'}}>Hệ thống sẽ chính thức ghi nhận điểm thưởng và cấp chứng nhận nếu đủ điều kiện.</p>
            <div className="modal-actions">
              <button onClick={() => setConfirmModal({isOpen: false, volunteer: null})} className="cancel-btn">Hủy</button>
              <button onClick={handleApprove} className="approve-btn-final">Xác Nhận Duyệt</button>
            </div>
          </div>
        </div>
      )}

      {/* Rejection Modal */}
      {rejectModal.isOpen && (
        <div className="custom-modal-overlay">
          <div className="custom-modal glassmorphism reject-modal">
            <h2>Từ chối Đánh giá</h2>
            <p>TNV: <strong>{rejectModal.volunteer.HoTen}</strong></p>
            <form onSubmit={handleReject}>
              <div className="form-group">
                <label>Lý do từ chối (Bắt buộc)</label>
                <textarea 
                  required 
                  value={rejectModal.reason} 
                  onChange={e => setRejectModal({...rejectModal, reason: e.target.value})}
                  placeholder="Nhập chi tiết lý do từ chối..."
                  rows="4"
                />
              </div>
              <div className="form-group">
                <label>Minh chứng đính kèm (Bắt buộc)</label>
                <div className="file-upload-wrapper">
                  <input 
                    type="file" 
                    id="proof-upload"
                    onChange={e => setRejectModal({...rejectModal, proof: e.target.files[0]})}
                    accept="image/*,.pdf"
                  />
                  <label htmlFor="proof-upload" className="file-label">
                    {rejectModal.proof ? rejectModal.proof.name : "Chọn tệp minh chứng..."}
                  </label>
                </div>
              </div>
              <div className="modal-actions">
                <button type="button" onClick={() => setRejectModal({isOpen: false, volunteer: null, reason: "", proof: null})} className="cancel-btn">Hủy</button>
                <button type="submit" className="reject-btn-final" disabled={!rejectModal.reason || !rejectModal.proof}>
                  Xác Nhận Từ Chối
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      <div className="evaluation-page-container">
        <div className="page-header">
          <div className="header-left">
             <h1>Đánh giá Tình nguyện viên</h1>
             {currentCampaign && (
               <div className="campaign-context-badge">
                 <span className="dot"></span>
                 Điều hành: <strong>{currentCampaign.TenChienDich || currentCampaign.TENCHIENDICH}</strong>
               </div>
             )}
          </div>
        </div>

        <GlassCard title="Danh sách Sinh viên đang tham gia">
          <div className="table-responsive">
            <table className="custom-table">
              <thead>
                <tr>
                  <th>TNV / MSSV</th>
                  <th>Họ Tên</th>
                  <th className="text-center">Tổng Giờ</th>
                  <th className="text-center">Điểm số</th>
                  <th className="text-center">Xếp Loại</th>
                  <th className="text-center">Thao Tác</th>
                </tr>
              </thead>
              <tbody>
                {Array.isArray(volunteers) && volunteers.map(v => (
                  <tr key={v.MaThamGia}>
                    <td><span className="mssv-tag">{v.MSSV}</span></td>
                    <td><div className="tnv-name-cell">{v.HoTen}</div></td>
                    <td className="text-center">
                      <span className="hour-badge-dynamic">{formatHours(v.TongGio)}</span>
                    </td>
                    <td className="text-center">
                      <input 
                        type="number" 
                        className="score-input-inline"
                        value={localScores[v.MaThamGia] || ''}
                        onChange={(e) => setLocalScores(prev => ({ ...prev, [v.MaThamGia]: e.target.value }))}
                        min="0"
                        max="10"
                        step="0.5"
                        placeholder="Nhập điểm..."
                      />
                    </td>
                    <td className="text-center">
                      <span className={`eval-badge ${getBadgeClass(getDynamicXepLoai(v))}`}>
                        {getBadgeName(getDynamicXepLoai(v))}
                      </span>
                    </td>
                    <td className="text-center">
                      <div className="action-group">
                        <button 
                          className="btn-approve-sm" 
                          onClick={() => setConfirmModal({isOpen: true, volunteer: v})}
                          title="Duyệt kết quả"
                        >
                          Duyệt
                        </button>
                        <button 
                          className="btn-reject-sm" 
                          onClick={() => setRejectModal({isOpen: true, volunteer: v, reason: "", proof: null})}
                          title="Từ chối/Hủy"
                        >
                          Không Duyệt
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {volunteers.length === 0 && !loading && (
                  <tr>
                    <td colSpan="6" className="empty-state">Chưa có tình nguyện viên nào đủ điều kiện đánh giá.</td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </GlassCard>
      </div>
    </MainLayout>
  );
};

export default EvaluationPage;
