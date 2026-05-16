import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import MainLayout from '../../components/layout/MainLayout';
import TimetableGrid from '../../components/dashboard/common/TimetableGrid';
import CampaignNotificationBox from '../../components/dashboard/bdh/CampaignNotificationBox';
import './TrangChiTietChienDich.css';

const API_URL = 'http://localhost:3000/api';

const TrangChiTietChienDich = () => {
  const { id } = useParams();
  const { user } = useAuth();
  const navigate = useNavigate();

  const [details, setDetails] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [showEvidenceModal, setShowEvidenceModal] = useState(false);
  const [evidenceUrl, setEvidenceUrl] = useState('');

  const [selectedTask, setSelectedTask] = useState(null);

  useEffect(() => {
    const fetchDetails = async () => {
      try {
        const username = user?.TenDangNhap || user?.tenDangNhap;
        if (!username) return;

        const response = await fetch(`${API_URL}/tnv/campaigns/${id}/details/${username}`);
        const data = await response.json();
        
        if (!response.ok) throw new Error(data.error || 'Failed to fetch details');
        
        setDetails(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchDetails();
  }, [id, user]);

  const handleUploadEvidence = async () => {
    if (!evidenceUrl) return;
    try {
      const res = await fetch(`${API_URL}/proof/upload`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          maThamGia: details.maThamGia, 
          hinhAnhUrl: evidenceUrl,
          loai: 'HoatDong'
        })
      });
      if (res.ok) {
        alert('Đã gửi minh chứng thành công!');
        setShowEvidenceModal(false);
        setEvidenceUrl('');
      } else {
        const data = await res.json();
        alert(data.error || 'Gửi minh chứng thất bại.');
      }
    } catch (err) { 
      console.error(err);
      alert('Lỗi kết nối: ' + err.message); 
    }
  };

  const formatHours = (hours) => {
    if (!hours && hours !== 0) return '0h';
    const h = Math.floor(hours);
    const m = Math.round((hours - h) * 60);
    if (m === 0) return `${h}h`;
    return `${h}h ${m}p`;
  };

  if (loading) return (
    <MainLayout>
      <div className="global-loading-container page-transition">
        <div className="spinner"></div>
        <p>Đang tải trang...</p>
      </div>
    </MainLayout>
  );
  if (error) return <MainLayout><div className="error-state page-transition">Lỗi: {error}</div></MainLayout>;
  if (!details) return <MainLayout><div className="error-state page-transition">Không có dữ liệu.</div></MainLayout>;

  // B. PROGRESS TRACKER LOGIC
  const { currentHours, thresholds } = details.progress;
  let nextRank = 'XuatSac';
  let hoursNeeded = thresholds.GIO_XUAT_SAC - currentHours;
  let progressPercent = 100;
  
  if (currentHours < thresholds.GIO_KHA) {
    nextRank = 'Khá';
    hoursNeeded = thresholds.GIO_KHA - currentHours;
    progressPercent = (currentHours / thresholds.GIO_KHA) * 100;
  } else if (currentHours < thresholds.GIO_TOT) {
    nextRank = 'Tốt';
    hoursNeeded = thresholds.GIO_TOT - currentHours;
    progressPercent = ((currentHours - thresholds.GIO_KHA) / (thresholds.GIO_TOT - thresholds.GIO_KHA)) * 100;
  } else if (currentHours < thresholds.GIO_XUAT_SAC) {
    nextRank = 'Xuất Sắc';
    hoursNeeded = thresholds.GIO_XUAT_SAC - currentHours;
    progressPercent = ((currentHours - thresholds.GIO_TOT) / (thresholds.GIO_XUAT_SAC - thresholds.GIO_TOT)) * 100;
  }

  return (
    <MainLayout>
      <div className="campaign-detail-container page-transition">
        
        {/* HEADER */}
        <header className="cd-header glass-panel">
          <button className="back-btn" onClick={() => navigate('/volunteer/dashboard')}>← Quay lại Dashboard</button>
          <div className="cd-header-content">
            <h1>{details.campaign.name}</h1>
            <div className="cd-meta">
              <span>📍 {details.campaign.location || 'Chưa xác định'}</span>
              <span>📅 {new Date(details.campaign.NgayBatDau).toLocaleDateString()} - {new Date(details.campaign.NgayKetThuc).toLocaleDateString()}</span>
              <span className="status-badge">{details.campaign.status}</span>
            </div>
          </div>
          <button className="submit-evidence-btn primary-btn" onClick={() => setShowEvidenceModal(true)}>
            📤 Nộp Minh Chứng
          </button>
        </header>

        <div className="cd-main-grid">
          
          <div className="cd-left-column">
            {/* PROGRESS TRACKER */}
            <section className="cd-progress glass-panel">
              <h3>Thanh Tiến Độ Tích Lũy</h3>
              <p>Tổng giờ đã tích lũy: <strong>{formatHours(currentHours)}</strong></p>
              {hoursNeeded > 0 ? (
                <p className="rank-hint">Bạn cần thêm <strong>{formatHours(hoursNeeded)}</strong> nữa để đạt danh hiệu <strong>{nextRank}</strong>.</p>
              ) : (
                <p className="rank-hint success">Chúc mừng! Bạn đã đạt danh hiệu cao nhất (Xuất Sắc).</p>
              )}
              <div className="progress-bar-container">
                <div className="progress-bar-fill" style={{ width: `${Math.min(progressPercent, 100)}%` }}></div>
              </div>
            </section>

            {/* TIMETABLE */}
            <section className="cd-timetable glass-panel">
              <TimetableGrid 
                tasks={details.tasks} 
                campaign={details.campaign} 
                readOnly={true}
                onTaskClick={(task) => setSelectedTask(task)}
              />
            </section>
          </div>

          <div className="cd-right-column">
            {/* COMMUNICATIONS BLOCK */}
            <CampaignNotificationBox 
              notifications={details.news} 
              readOnly={true} 
            />
          </div>
          
        </div>
      </div>

      {/* MODALS */}
      {showEvidenceModal && (
        <div className="custom-modal-overlay">
          <div className="custom-modal glass-modal">
            <h3>Nộp Minh Chứng Hoạt Động</h3>
            <p>Vui lòng cung cấp link hình ảnh hoặc tài liệu minh chứng cho hoạt động của bạn hôm nay.</p>
            <div className="form-group">
              <input 
                type="text" 
                placeholder="https://imgur.com/..." 
                value={evidenceUrl} 
                onChange={e => setEvidenceUrl(e.target.value)} 
                className="modal-input"
              />
            </div>
            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => setShowEvidenceModal(false)}>Hủy</button>
              <button className="btn-primary" onClick={handleUploadEvidence}>Gửi minh chứng</button>
            </div>
          </div>
        </div>
      )}

      {selectedTask && (
        <div className="custom-modal-overlay">
          <div className="custom-modal glass-modal">
            <h3>{selectedTask.TenCongViec}</h3>
            <div className="task-detail-info">
              <p><strong>Thời gian:</strong> {new Date(selectedTask.ThoiGianBatDau).toLocaleString('vi-VN')}</p>
              <p><strong>Mô tả:</strong> {selectedTask.MoTa || 'Không có mô tả'}</p>
            </div>
            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => setSelectedTask(null)}>Đóng</button>
            </div>
          </div>
        </div>
      )}
    </MainLayout>
  );
};

export default TrangChiTietChienDich;
