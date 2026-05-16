import React, { useState } from 'react';

const AssignModal = ({ volunteer, onClose, onSubmit }) => {
  const [formData, setFormData] = useState({
    team: '',
    role: 'Thành viên'
  });

  return (
    <div className="custom-modal-overlay" style={{ zIndex: 2000 }}>
      <div className="custom-modal assign-modal" style={{ maxWidth: '400px' }}>
        <h2 style={{ color: '#F58220', marginBottom: '1.5rem' }}>Phân công nhiệm vụ</h2>
        
        <div style={{ marginBottom: '1.5rem' }}>
          <p style={{ color: '#64748b', fontSize: '0.95rem' }}>
            Cho TNV: <strong>{volunteer.HOTEN || volunteer.HoTen}</strong>
          </p>
        </div>

        <form onSubmit={(e) => { e.preventDefault(); onSubmit(formData); }}>
          <div className="form-group" style={{ marginBottom: '1.5rem' }}>
            <label style={{ display: 'block', marginBottom: '0.5rem', color: '#94a3b8' }}>Tên nhiệm vụ / Đội nhóm</label>
            <input 
              type="text" 
              placeholder="VD: Đội Hậu Cần, Đội Truyền Thông..."
              value={formData.team}
              onChange={(e) => setFormData({ ...formData, team: e.target.value })}
              style={{ width: '100%', padding: '0.75rem', border: '1px solid #e2e8f0', borderRadius: '8px' }}
              required
            />
          </div>

          <div className="form-group" style={{ marginBottom: '2rem' }}>
            <label style={{ display: 'block', marginBottom: '0.5rem', color: '#94a3b8' }}>Vai trò cụ thể</label>
            <select 
              value={formData.role}
              onChange={(e) => setFormData({ ...formData, role: e.target.value })}
              style={{ width: '100%', padding: '0.75rem', border: '1px solid #e2e8f0', borderRadius: '8px' }}
            >
              <option value="Thành viên">Thành viên</option>
              <option value="Trưởng nhóm">Trưởng nhóm</option>
              <option value="Phó nhóm">Phó nhóm</option>
              <option value="Hỗ trợ">Hỗ trợ</option>
            </select>
          </div>

          <div className="modal-actions" style={{ display: 'flex', gap: '1rem', justifyContent: 'flex-end' }}>
            <button type="button" className="btn-close" onClick={onClose} style={{ flex: 1 }}>Hủy</button>
            <button type="submit" className="btn-approve" style={{ flex: 1, background: '#F58220' }}>Phân công</button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AssignModal;
