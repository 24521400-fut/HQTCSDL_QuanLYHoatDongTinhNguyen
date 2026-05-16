import React, { useState } from 'react';
import './GlassCalendar.css';

const GlassCalendar = ({ attendanceDates, personalEvents, onAddEvent }) => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [showModal, setShowModal] = useState(false);
  const [selectedDate, setSelectedDate] = useState(null);
  const [newEvent, setNewEvent] = useState({ title: '', notes: '' });

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const firstDayOfMonth = new Date(year, month, 1).getDay();

  // Bảng màu cứng theo yêu cầu
  const COLORS = ["#F58220", "#F44336", "#0D1B2A", "#9C27B0", "#4CAF50", "#2196F3"];

  const days = [];
  for (let i = 0; i < firstDayOfMonth; i++) {
    days.push(null);
  }
  for (let i = 1; i <= daysInMonth; i++) {
    days.push(i);
  }

  const handlePrevMonth = () => {
    setCurrentDate(new Date(year, month - 1, 1));
  };

  const handleNextMonth = () => {
    setCurrentDate(new Date(year, month + 1, 1));
  };

  const handleDateClick = (day) => {
    if (!day) return;
    const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    setSelectedDate(dateStr);
    setShowModal(true);
  };

  const submitEvent = () => {
    if (newEvent.title.trim() === '') return;
    onAddEvent({
      date: selectedDate,
      ...newEvent
    });
    setShowModal(false);
    setNewEvent({ title: '', notes: '' });
  };

  return (
    <div className="glass-calendar-container">
      <div className="calendar-header">
        <button onClick={handlePrevMonth}>&lt;</button>
        <h3>{currentDate.toLocaleString('default', { month: 'long', year: 'numeric' })}</h3>
        <button onClick={handleNextMonth}>&gt;</button>
      </div>
      
      <div className="calendar-grid">
        {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((d) => (
          <div key={d} className="day-name">{d}</div>
        ))}
        {days.map((day, idx) => {
          if (!day) return <div key={idx} className="day-cell empty"></div>;
          
          const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
          const dayCampaigns = attendanceDates.filter(d => d.date === dateStr);
          const dayPersonal = personalEvents.filter(e => e.date.startsWith(dateStr));

          return (
            <div key={idx} className="day-cell" onClick={() => handleDateClick(day)}>
              <span className="day-number" style={{ color: dayCampaigns.length > 0 || dayPersonal.length > 0 ? '#F58220' : 'inherit' }}>{day}</span>
              <div className="dots-container">
                {dayCampaigns.map((camp, i) => (
                  <div key={`camp-${i}`} className="dot" style={{ backgroundColor: COLORS[i % COLORS.length] }}></div>
                ))}
                {dayPersonal.map((pe, i) => (
                  <div key={`pe-${i}`} className="dot" style={{ backgroundColor: COLORS[(dayCampaigns.length + i) % COLORS.length] }}></div>
                ))}
              </div>
              
              {(dayCampaigns.length > 0 || dayPersonal.length > 0) && (
                <div className="day-tooltip">
                  {dayCampaigns.map((camp, i) => (
                    <div key={`t-camp-${i}`} className="tooltip-item">
                      <span className="tooltip-dot" style={{ backgroundColor: COLORS[i % COLORS.length] }}></span>
                      <span>{camp.campaignName}</span>
                    </div>
                  ))}
                  {dayPersonal.map((pe, i) => (
                    <div key={`t-pe-${i}`} className="tooltip-item">
                      <span className="tooltip-dot" style={{ backgroundColor: COLORS[(dayCampaigns.length + i) % COLORS.length] }}></span>
                      <span>{pe.title || "Sự kiện cá nhân"}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {showModal && (
        <div className="modal-overlay">
          <div className="modal-content glass-modal">
            <h4>Thêm Sự Kiện Mới ({selectedDate})</h4>
            <input 
              type="text" 
              placeholder="Tiêu đề sự kiện" 
              value={newEvent.title}
              onChange={(e) => setNewEvent({...newEvent, title: e.target.value})}
            />
            <textarea 
              placeholder="Ghi chú (tùy chọn)" 
              value={newEvent.notes}
              onChange={(e) => setNewEvent({...newEvent, notes: e.target.value})}
            />
            <div className="modal-actions">
              <button onClick={() => setShowModal(false)}>Hủy</button>
              <button onClick={submitEvent}>Lưu</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default GlassCalendar;
