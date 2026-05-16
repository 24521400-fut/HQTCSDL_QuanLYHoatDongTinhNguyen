import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import MainLayout from '../../components/layout/MainLayout';
import SystemModal from '../../components/common/SystemModal';
import './TaskDetailPage.css';

const TaskDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [task, setTask] = useState(null);
  const [volunteers, setVolunteers] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  // Assign Modal
  const [assignModal, setAssignModal] = useState({ isOpen: false, volunteer: null });
  const [assignData, setAssignData] = useState({ vaiTro: 'Thành viên' });

  const fetchData = async () => {
    try {
      // In a real app, we'd have a specific endpoint for one task, 
      // but here we might need to fetch from context or list.
      // For simplicity, let's assume there's a /api/bdh/task/:id endpoint.
      const res = await fetch(`http://localhost:3000/api/bdh/task/${id}`);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Lỗi tải công việc');
      setTask(data);

      const vRes = await fetch(`http://localhost:3000/api/bdh/volunteers/${data.MaChienDich}`);
      const vData = await vRes.json();
      setVolunteers(vData);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [id]);

  const handleUpdateTask = async (e) => {
    e.preventDefault();
    try {
      const res = await fetch(`http://localhost:3000/api/bdh/task/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(task)
      });
      if (res.ok) {
        alert('Cập nhật thành công!');
        fetchData();
      }
    } catch (err) { alert(err.message); }
  };

  const handleAssign = async (e) => {
    e.preventDefault();
    try {
      const res = await fetch('http://localhost:3000/api/executive/assign-task', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          maThamGia: assignModal.volunteer.MaThamGia,
          maChienDich: task.MaChienDich,
          tenNhiemVu: task.TenCongViec,
          vaiTro: assignData.vaiTro
        })
      });
      if (res.ok) {
        setAssignModal({ isOpen: false, volunteer: null });
        alert('Phân công thành công!');
      }
    } catch (err) { alert(err.message); }
  };

  const filteredVolunteers = volunteers.filter(v => 
    v.HoTen.toLowerCase().includes(searchQuery.toLowerCase()) || 
    v.MSSV.includes(searchQuery)
  );

  if (loading) return (
    <MainLayout>
      <div className="global-loading-container page-transition">
        <div className="spinner"></div>
        <p>Đang tải trang...</p>
      </div>
    </MainLayout>
  );
  if (error) return <MainLayout><div className="error">{error}</div></MainLayout>;

  return (
    <MainLayout>
      <div className="task-detail-container">
        <div className="task-detail-header">
          <button className="back-btn" onClick={() => navigate('/executive/dashboard')}>← Quay lại Dashboard</button>
          <h1>Chi tiết công việc</h1>
        </div>

        <div className="task-detail-grid">
          {/* Edit Task Column */}
          <div className="glass-panel edit-task-form">
            <h3>Thông tin nhiệm vụ</h3>
            <form onSubmit={handleUpdateTask}>
              <div className="form-group">
                <label>Tên công việc</label>
                <input value={task.TenCongViec} onChange={e => setTask({...task, TenCongViec: e.target.value})} />
              </div>
              <div className="form-group">
                <label>Mô tả</label>
                <textarea rows="4" value={task.MoTa} onChange={e => setTask({...task, MoTa: e.target.value})} />
              </div>
              <div className="form-group">
                <label>Thời gian bắt đầu</label>
                <input type="datetime-local" value={new Date(task.ThoiGianBatDau).toISOString().slice(0,16)} 
                       onChange={e => setTask({...task, ThoiGianBatDau: e.target.value})} />
              </div>
              <button type="submit" className="btn-primary">Cập nhật thay đổi</button>
            </form>
          </div>

          {/* Volunteer Assignment Column */}
          <div className="glass-panel assignment-section">
            <div className="section-header">
              <h3>Phân công nhân sự</h3>
              <input 
                type="text" 
                placeholder="Tìm TNV theo tên hoặc MSSV..." 
                value={searchQuery}
                onChange={e => setSearchQuery(e.target.value)}
                className="search-input"
              />
            </div>
            <div className="volunteer-list scrollable">
              {filteredVolunteers.map(v => (
                <div key={v.MaThamGia} className="volunteer-item">
                  <div className="v-info">
                    <strong>{v.HoTen}</strong>
                    <span>{v.MSSV} - {v.Lop}</span>
                  </div>
                  <button className="btn-assign-small" onClick={() => setAssignModal({isOpen: true, volunteer: v})}>Phân công</button>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Assignment Modal */}
        {assignModal.isOpen && (
          <div className="custom-modal-overlay">
            <div className="custom-modal">
              <h3>Phân công: {assignModal.volunteer.HoTen}</h3>
              <p>Nhiệm vụ: <strong>{task.TenCongViec}</strong></p>
              <form onSubmit={handleAssign}>
                <div className="form-group">
                  <label>Vai trò</label>
                  <select value={assignData.vaiTro} onChange={e => setAssignData({vaiTro: e.target.value})}>
                    <option value="Trưởng nhóm">Trưởng nhóm</option>
                    <option value="Thành viên">Thành viên</option>
                    <option value="Hậu cần">Hậu cần</option>
                  </select>
                </div>
                <div className="modal-actions">
                  <button type="button" className="btn-close" onClick={() => setAssignModal({isOpen: false, volunteer: null})}>Hủy</button>
                  <button type="submit" className="btn-primary">Xác nhận phân công</button>
                </div>
              </form>
            </div>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default TaskDetailPage;
