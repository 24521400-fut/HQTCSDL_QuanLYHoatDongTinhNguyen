import React, { useState, useEffect } from 'react';
import AssignModal from './AssignModal';

const TaskDetailView = ({ task, campaign, onClose, onRefresh }) => {
  const [volunteers, setVolunteers] = useState([]);
  const [assigned, setAssigned] = useState([]);
  const [showAssignModal, setShowAssignModal] = useState(null); // stores the volunteer object to assign
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, [task]);

  const fetchData = async () => {
    setLoading(true);
    try {
      const maCD = campaign.MaChienDich || campaign.MACHIENDICH;
      const maCV = task.MaCongViec || task.MACONGVIEC;
      const [volRes, assignRes] = await Promise.all([
        fetch(`http://localhost:3000/api/bdh/volunteers/${maCD}`),
        fetch(`http://localhost:3000/api/bdh/tasks/${maCV}/assigned`)
      ]);
      const volData = await volRes.json();
      const assignData = await assignRes.json();
      
      // Normalize to uppercase for consistent access
      setVolunteers(volData.map(v => {
        const n = {};
        Object.keys(v).forEach(k => n[k.toUpperCase()] = v[k]);
        return n;
      }));
      setAssigned(assignData.map(a => {
        const n = {};
        Object.keys(a).forEach(k => n[k.toUpperCase()] = a[k]);
        return n;
      }));
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleAssign = async (formData) => {
    try {
      const res = await fetch('http://localhost:3000/api/bdh/tasks/assign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          maCV: task.MaCongViec,
          maTG: showAssignModal.MATHAMGIA || showAssignModal.MaThamGia,
          vaiTroCuThe: formData.role,
          tenNhiemVu: formData.team
        })
      });
      if (res.ok) {
        setShowAssignModal(null);
        fetchData();
        onRefresh();
      } else {
        const data = await res.json();
        alert(data.error);
      }
    } catch (err) {
      alert(err.message);
    }
  };

  const isAssigned = (maTG) => {
    if (!maTG) return false;
    return assigned.some(a => a.MATHAMGIA === maTG);
  };

  return (
    <div className="custom-modal-overlay">
      <div className="custom-modal task-detail-modal">
        <div className="modal-header" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
          <h2 style={{ margin: 0, color: '#F58220', fontSize: '1.4rem' }}>Chi tiết công việc</h2>
          <button 
            onClick={onClose}
            style={{
              background: 'none',
              border: '2px solid #e2e8f0',
              borderRadius: '50%',
              width: '36px',
              height: '36px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              fontSize: '1rem',
              color: '#64748b',
              transition: 'all 0.2s'
            }}
            onMouseOver={e => { e.target.style.borderColor = '#F58220'; e.target.style.color = '#F58220'; }}
            onMouseOut={e => { e.target.style.borderColor = '#e2e8f0'; e.target.style.color = '#64748b'; }}
          >✕</button>
        </div>

        <div className="task-info-grid">
          <div className="info-item">
            <label>Tên công việc</label>
            <p>{task.TenCongViec}</p>
          </div>
          <div className="info-item">
            <label>Thời gian</label>
            <p>{new Date(task.ThoiGianBatDau).toLocaleString()} - {new Date(task.ThoiGianKetThuc).toLocaleTimeString()}</p>
          </div>
          <div className="info-item">
            <label>Số lượng TNV</label>
            <p>{assigned.length} / {task.SoLuongTNVCan}</p>
          </div>
        </div>
        {task.MoTa && (
          <div style={{ padding: '1rem 1.5rem', background: '#f8fafc', borderRadius: '12px', marginBottom: '1.5rem', marginTop: '-0.5rem' }}>
            <label style={{ display: 'block', fontSize: '0.8rem', color: '#64748b', marginBottom: '0.25rem' }}>Mô tả công việc</label>
            <p style={{ fontWeight: 500, color: '#1e293b', margin: 0, lineHeight: 1.5 }}>{task.MoTa}</p>
          </div>
        )}

        <div className="volunteer-assignment-section">
          <h3>Danh sách TNV chiến dịch</h3>
          <div className="vol-list scrollable">
            {loading ? <p>Đang tải...</p> : (
              volunteers.map(vol => {
                const maTG = vol.MATHAMGIA;
                const assignedInfo = maTG ? assigned.find(a => a.MATHAMGIA === maTG) : null;
                
                return (
                  <div key={maTG} className="vol-item">
                    <div className="vol-info">
                      <strong>{vol.HOTEN}</strong>
                      <span>{vol.MASINHVIEN || vol.MSSV}</span>
                    </div>
                    {assignedInfo ? (
                      <div className="assigned-badge">
                        <span>{assignedInfo.VAITROCUTHE}</span>
                        <span className="status-dot"></span>
                      </div>
                    ) : (
                      <button 
                        className="btn-assign"
                        disabled={assigned.length >= task.SoLuongTNVCan}
                        onClick={() => setShowAssignModal(vol)}
                      >
                        PHÂN CÔNG
                      </button>
                    )}
                  </div>
                );
              })
            )}
          </div>
        </div>

        {showAssignModal && (
          <AssignModal 
            key={showAssignModal.MATHAMGIA}
            volunteer={showAssignModal}
            onClose={() => setShowAssignModal(null)}
            onSubmit={handleAssign}
          />
        )}
      </div>

      <style jsx>{`
        .task-detail-modal {
          max-width: 800px;
          width: 90%;
        }
        .task-info-grid {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 1.5rem;
          margin-bottom: 2rem;
          padding: 1.5rem;
          background: #f8fafc;
          border-radius: 12px;
        }
        .info-item label {
          display: block;
          font-size: 0.8rem;
          color: #64748b;
          margin-bottom: 0.25rem;
        }
        .info-item p {
          font-weight: 600;
          color: #1e293b;
        }
        .volunteer-assignment-section h3 {
          margin-bottom: 1rem;
          font-size: 1.1rem;
        }
        .vol-list {
          max-height: 400px;
          display: flex;
          flex-direction: column;
          gap: 0.75rem;
        }
        .vol-item {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 1rem;
          background: white;
          border: 1px solid #e2e8f0;
          border-radius: 8px;
          transition: all 0.2s;
        }
        .vol-info {
          display: flex;
          flex-direction: column;
        }
        .vol-info span {
          font-size: 0.85rem;
          color: #64748b;
        }
        .btn-assign {
          background: #F58220;
          color: white;
          border: none;
          padding: 0.5rem 1rem;
          border-radius: 6px;
          font-weight: 600;
          cursor: pointer;
        }
        .btn-assign:disabled {
          background: #cbd5e1;
          cursor: not-allowed;
        }
        .assigned-badge {
          display: flex;
          align-items: center;
          gap: 0.5rem;
          color: #10b981;
          font-weight: 600;
          font-size: 0.9rem;
        }
        .status-dot {
          width: 8px;
          height: 8px;
          background: #10b981;
          border-radius: 50%;
        }
      `}</style>
    </div>
  );
};

export default TaskDetailView;
