import React, { useState } from 'react';

const CampaignNotificationBox = ({ notifications, onAddNotification, readOnly = false }) => {
  const [showModal, setShowModal] = useState(false);
  const [newNotif, setNewNotif] = useState({ title: '', content: '' });

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!newNotif.title.trim() || !newNotif.content.trim()) return;
    onAddNotification(newNotif.content, newNotif.title);
    setNewNotif({ title: '', content: '' });
    setShowModal(false);
  };

  return (
    <div className="utility-box notification-box" style={{ position: 'relative' }}>
      <div className="box-header">
        <h4>TIN NỔI BẬT</h4>
      </div>
      <div className="box-content scrollable">
        {notifications.length === 0 ? (
          <div className="empty-state">Chưa có thông báo nào.</div>
        ) : (
          <div className="news-bulletin-list">
            {notifications.map(notif => (
              <div key={notif.MaTinTuc || notif.id} className="news-bulletin-item">
                <div className="bulletin-header">
                  <span className="bullet-point">›</span>
                  <strong className="bulletin-title">{notif.TieuDe || notif.title || 'Thông báo'}</strong>
                </div>
                <div className="bulletin-meta">
                  {new Date(notif.NgayDang || notif.date).toLocaleDateString('vi-VN')} - {new Date(notif.NgayDang || notif.date).toLocaleTimeString('vi-VN', {hour:'2-digit', minute:'2-digit'})}
                </div>
                <p className="bulletin-excerpt">{notif.NoiDung || notif.content}</p>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Floating Add Button */}
      {!readOnly && (
        <button 
          className="floating-add-btn" 
          onClick={() => setShowModal(true)}
          title="Tạo thông báo mới"
        >
          +
        </button>
      )}

      {/* Create Notification Modal */}
      {showModal && (
        <div className="custom-modal-overlay">
          <div className="custom-modal">
            <h3>Tạo thông báo mới</h3>
            <form onSubmit={handleSubmit} className="notif-form">
              <div className="form-group">
                <label>Tiêu đề</label>
                <input 
                  type="text" 
                  value={newNotif.title}
                  onChange={e => setNewNotif({...newNotif, title: e.target.value})}
                  placeholder="Nhập tiêu đề thông báo..."
                  required
                />
              </div>
              <div className="form-group">
                <label>Nội dung</label>
                <textarea 
                  value={newNotif.content}
                  onChange={e => setNewNotif({...newNotif, content: e.target.value})}
                  placeholder="Nhập nội dung chi tiết..."
                  rows="4"
                  required
                />
              </div>
              <div className="modal-actions">
                <button type="button" className="btn-close" onClick={() => setShowModal(false)}>Hủy</button>
                <button type="submit" className="btn-approve">Đăng thông báo</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default CampaignNotificationBox;

