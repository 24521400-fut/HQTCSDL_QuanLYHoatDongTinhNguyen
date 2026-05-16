import React, { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../context/AuthContext";
import "./ThongBaoDropdown.css";

const ThongBaoDropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [notifications, setNotifications] = useState([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const { user } = useAuth();
  const navigate = useNavigate();
  const dropdownRef = useRef(null);

  const [expanded, setExpanded] = useState(false);

  useEffect(() => {
    if (user && (user.TenDangNhap || user.tenDangNhap)) {
      fetchNotifications();
    }
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false);
        setExpanded(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [user]);

  const fetchNotifications = async () => {
    try {
      const username = user.TenDangNhap || user.tenDangNhap;
      const res = await fetch(`http://localhost:3000/api/notifications/${username}`);
      if (res.ok) {
        const data = await res.json();
        setNotifications(data);
        const count = data.filter(n => n.status === 'ChuaDoc' || n.TRANGTHAI === 'ChuaDoc').length;
        setUnreadCount(count);
      }
    } catch (error) {
      console.error("Lỗi lấy thông báo:", error);
    }
  };

  const markAsRead = async (id) => {
    try {
      const username = user.TenDangNhap || user.tenDangNhap;
      await fetch(`http://localhost:3000/api/notifications/${username}/${id}/read`, {
        method: 'PUT'
      });
      fetchNotifications();
    } catch (error) {
      console.error(error);
    }
  };

  const handleNotificationClick = (noti) => {
    const id = noti.id || noti.MaThongBao;
    const status = noti.status || noti.TrangThai;
    if (status === 'ChuaDoc') {
      markAsRead(id);
    }
  };

  const formatRelativeTime = (dateString) => {
    if (!dateString) return '';
    const notiDate = new Date(dateString);
    const now = new Date();
    const diffMs = now - notiDate;
    const diffMins = Math.floor(diffMs / 60000);
    
    if (diffMins < 60) return `cách đây ${diffMins} phút`;
    const diffHrs = Math.floor(diffMins / 60);
    if (diffHrs < 24) return `cách đây ${diffHrs} giờ`;
    const diffDays = Math.floor(diffHrs / 24);
    return `cách đây ${diffDays} ngày`;
  };

  const displayList = expanded ? notifications : notifications.slice(0, 5);

  return (
    <div className="thongbao-container" ref={dropdownRef}>
      <button className="thongbao-bell-btn" onClick={() => setIsOpen(!isOpen)}>
        🔔
        {unreadCount > 0 && <span className="thongbao-badge"></span>}
      </button>

      {isOpen && (
        <div className="thongbao-dropdown">
          <div className="thongbao-header">
            <h3>Các thông báo</h3>
            <div className="header-actions">
              <button className="icon-btn" title="Đánh dấu tất cả là đã đọc">✔️</button>
              <button className="icon-btn" title="Cài đặt">⚙️</button>
            </div>
          </div>
          
          <div className="thongbao-list" style={{ maxHeight: expanded ? '500px' : '350px' }}>
            {displayList.length === 0 ? (
              <div className="thongbao-empty">Không có thông báo nào</div>
            ) : (
              displayList.map(noti => {
                const id = noti.id || noti.MaThongBao;
                const status = noti.status || noti.TrangThai;
                const title = noti.title || noti.TieuDe;
                const date = noti.date || noti.NgayGui;
                
                return (
                  <div 
                    key={id} 
                    className={`thongbao-item ${status === 'ChuaDoc' ? 'unread' : ''}`}
                    onClick={() => handleNotificationClick(noti)}
                  >
                    <div className="thongbao-item-content">
                      <div className="noti-icon-wrapper">💡</div>
                      <div className="noti-text-wrapper">
                        <h4 className="thongbao-title">{title}</h4>
                        <div className="thongbao-meta-row">
                          <span className="thongbao-time">{formatRelativeTime(date)}</span>
                          <span className="view-link">Xem chi tiết</span>
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })
            )}
          </div>
          
          {!expanded && notifications.length > 5 && (
            <div className="thongbao-footer">
              <button className="thongbao-see-all" onClick={() => setExpanded(true)}>
                See all
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default ThongBaoDropdown;

