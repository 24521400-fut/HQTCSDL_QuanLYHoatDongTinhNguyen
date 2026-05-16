import React, { useState } from 'react';
import './GanttChart.css';

const GanttChart = ({ tasks, campaign, onAddTask }) => {
  const [showModal, setShowModal] = useState(false);
  const [newTask, setNewTask] = useState({
    name: '',
    desc: '',
    startDate: '',
    endDate: ''
  });
  const [error, setError] = useState('');

  if (!campaign || !campaign.NgayBatDau) {
    return <div style={{ color: '#A0AEC0' }}>Đang tải dữ liệu chiến dịch...</div>;
  }

  const campStart = new Date(campaign.NgayBatDau).getTime();
  // If campaign has no end date, we default to start + 30 days
  const campEnd = campaign.NgayKetThuc 
    ? new Date(campaign.NgayKetThuc).getTime() 
    : campStart + 30 * 24 * 60 * 60 * 1000;
  
  const totalDuration = campEnd - campStart;

  const calculateStyle = (taskStartStr, taskEndStr) => {
    const tStart = new Date(taskStartStr).getTime();
    // Default to start + 1 day if no end date
    const tEnd = taskEndStr ? new Date(taskEndStr).getTime() : tStart + 24 * 60 * 60 * 1000;

    let leftPercent = ((tStart - campStart) / totalDuration) * 100;
    let widthPercent = ((tEnd - tStart) / totalDuration) * 100;

    // Boundary checks
    if (leftPercent < 0) leftPercent = 0;
    if (leftPercent > 100) leftPercent = 100;
    if (leftPercent + widthPercent > 100) widthPercent = 100 - leftPercent;

    return {
      left: `${leftPercent}%`,
      width: `${widthPercent}%`
    };
  };

  const handleAddSubmit = async (e) => {
    e.preventDefault();
    setError('');

    if (campaign.NgayKetThuc && new Date(newTask.endDate) > new Date(campaign.NgayKetThuc)) {
      setError('Lỗi: Thời gian kết thúc công việc không được vượt quá thời gian kết thúc chiến dịch!');
      return;
    }
    
    if (new Date(newTask.startDate) > new Date(newTask.endDate)) {
      setError('Lỗi: Thời gian kết thúc phải sau thời gian bắt đầu!');
      return;
    }

    try {
      await onAddTask(newTask);
      setShowModal(false);
      setNewTask({ name: '', desc: '', startDate: '', endDate: '' });
    } catch (err) {
      setError(err.message || 'Có lỗi xảy ra');
    }
  };

  return (
    <div className="gantt-wrapper">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
        <h3 style={{ color: '#E2E8F0', margin: 0 }}>Lịch Điều Phối Tổng Thể</h3>
        <button className="add-task-btn" onClick={() => setShowModal(true)}>+ Thêm Công Việc</button>
      </div>

      <div className="gantt-container">
        <div className="gantt-header">
          <div className="gantt-task-name">Tên Công Việc</div>
          <div className="gantt-timeline" style={{ display: 'flex', justifyContent: 'space-between' }}>
            <span>{new Date(campStart).toLocaleDateString('vi-VN')}</span>
            <span>{new Date(campEnd).toLocaleDateString('vi-VN')}</span>
          </div>
        </div>

        {tasks.map(task => {
          const style = calculateStyle(task.ThoiGianBatDau, task.ThoiGianKetThuc);
          return (
            <div key={task.MaCongViec} className="gantt-row">
              <div className="gantt-task-name" title={task.TenCongViec}>{task.TenCongViec}</div>
              <div className="gantt-timeline">
                <div className="gantt-bar" style={style}>
                  <div className="gantt-bar-tooltip">
                    <strong>{task.TenCongViec}</strong><br/>
                    Bắt đầu: {new Date(task.ThoiGianBatDau).toLocaleString('vi-VN')}<br/>
                    Kết thúc: {task.ThoiGianKetThuc ? new Date(task.ThoiGianKetThuc).toLocaleString('vi-VN') : 'N/A'}
                  </div>
                </div>
              </div>
            </div>
          );
        })}
        {tasks.length === 0 && <div style={{ padding: '1rem', color: '#A0AEC0' }}>Chưa có công việc nào.</div>}
      </div>

      {showModal && (
        <div className="modal-overlay" style={modalStyles.overlay}>
          <div className="modal-content" style={modalStyles.content}>
            <h3 style={{ marginTop: 0, color: '#F58220' }}>Thêm Công Việc Mới</h3>
            {error && <div style={{ color: '#FC8181', marginBottom: '1rem', fontSize: '0.9rem' }}>{error}</div>}
            
            <form onSubmit={handleAddSubmit}>
              <div className="form-group" style={{ marginBottom: '1rem' }}>
                <label style={{ display: 'block', marginBottom: '0.5rem' }}>Tên công việc</label>
                <input required type="text" style={modalStyles.input} value={newTask.name} onChange={e => setNewTask({...newTask, name: e.target.value})} />
              </div>
              <div className="form-group" style={{ marginBottom: '1rem' }}>
                <label style={{ display: 'block', marginBottom: '0.5rem' }}>Mô tả</label>
                <textarea style={modalStyles.input} value={newTask.desc} onChange={e => setNewTask({...newTask, desc: e.target.value})} />
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                <div className="form-group">
                  <label style={{ display: 'block', marginBottom: '0.5rem' }}>Bắt đầu</label>
                  <input required type="datetime-local" style={modalStyles.input} value={newTask.startDate} onChange={e => setNewTask({...newTask, startDate: e.target.value})} />
                </div>
                <div className="form-group">
                  <label style={{ display: 'block', marginBottom: '0.5rem' }}>Kết thúc</label>
                  <input required type="datetime-local" style={modalStyles.input} value={newTask.endDate} onChange={e => setNewTask({...newTask, endDate: e.target.value})} />
                </div>
              </div>
              <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                <button type="button" onClick={() => setShowModal(false)} style={modalStyles.btnCancel}>Hủy</button>
                <button type="submit" style={modalStyles.btnSubmit}>Lưu công việc</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

const modalStyles = {
  overlay: {
    position: 'fixed',
    top: 0, left: 0, right: 0, bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 1000,
    backdropFilter: 'blur(4px)'
  },
  content: {
    backgroundColor: '#1A202C',
    padding: '2rem',
    borderRadius: '12px',
    width: '500px',
    maxWidth: '90%',
    border: '1px solid rgba(255, 255, 255, 0.1)',
    boxShadow: '0 10px 25px rgba(0, 0, 0, 0.5)'
  },
  input: {
    width: '100%',
    padding: '0.75rem',
    borderRadius: '6px',
    border: '1px solid rgba(255, 255, 255, 0.2)',
    backgroundColor: 'rgba(0, 0, 0, 0.2)',
    color: '#FFF'
  },
  btnCancel: {
    padding: '0.5rem 1rem',
    borderRadius: '6px',
    border: '1px solid rgba(255, 255, 255, 0.2)',
    background: 'transparent',
    color: '#E2E8F0',
    cursor: 'pointer'
  },
  btnSubmit: {
    padding: '0.5rem 1.5rem',
    borderRadius: '6px',
    border: 'none',
    background: '#F58220',
    color: '#FFF',
    cursor: 'pointer',
    fontWeight: 'bold'
  }
};

export default GanttChart;
