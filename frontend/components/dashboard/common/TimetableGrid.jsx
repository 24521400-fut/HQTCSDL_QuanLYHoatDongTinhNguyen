import React, { useState } from 'react';
import TaskBlock from './TaskBlock';
import './TimetableGrid.css';

const COLORS = ["#F58220", "#F44336", "#0D1B2A", "#9C27B0", "#4CAF50", "#2196F3"];

// Định nghĩa các Tiết học theo hệ thống LMS (Image 1)
const PERIODS = [
  { id: 1, start: 7.5, end: 8.25, time: '07:30 - 08:15', session: 'Morning' },
  { id: 2, start: 8.25, end: 9.0, time: '08:15 - 09:00', session: 'Morning' },
  { id: 3, start: 9.0, end: 9.75, time: '09:00 - 09:45', session: 'Morning' },
  { id: 4, start: 10.0, end: 10.75, time: '10:00 - 10:45', session: 'Morning' },
  { id: 5, start: 10.75, end: 11.5, time: '10:45 - 11:30', session: 'Morning' },
  // Nghỉ trưa
  { id: 6, start: 13.0, end: 13.75, time: '13:00 - 13:45', session: 'Afternoon' },
  { id: 7, start: 13.75, end: 14.5, time: '13:45 - 14:30', session: 'Afternoon' },
  { id: 8, start: 14.5, end: 15.25, time: '14:30 - 15:15', session: 'Afternoon' },
  { id: 9, start: 15.5, end: 16.25, time: '15:30 - 16:15', session: 'Afternoon' },
  { id: 10, start: 16.25, end: 17.0, time: '16:15 - 17:00', session: 'Afternoon' },
  { id: 11, start: 17.0, end: 17.75, time: '17:00 - 17:45', session: 'Afternoon' },
  // Nghỉ chiều
  { id: 12, start: 18.5, end: 19.25, time: '18:30 - 19:15', session: 'Afternoon' },
  { id: 13, start: 19.25, end: 20.0, time: '19:15 - 20:00', session: 'Afternoon' },
  { id: 14, start: 20.0, end: 20.75, time: '20:00 - 20:45', session: 'Afternoon' },
  { id: 15, start: 21.0, end: 21.75, time: '21:00 - 21:45', session: 'Afternoon' },
];

const SLOT_HEIGHT = 35; // Chiều cao mỗi hàng thời gian (px)

const TimetableGrid = ({ tasks, campaign, onTaskClick, readOnly = false }) => {
  const getMonday = (d) => {
    d = new Date(d);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? -6 : 1); 
    return new Date(d.setDate(diff));
  };

  const campaignStart = new Date(campaign.NgayBatDau || campaign.NGAYBATDAU);
  const campaignEnd = new Date(campaign.NgayKetThuc || campaign.NGAYKETTHUC);
  const minWeekStart = getMonday(campaignStart);
  const maxWeekStart = getMonday(campaignEnd);

  const [weekStart, setWeekStart] = useState(minWeekStart);
  const daysShort = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  
  const weekDates = Array.from({ length: 7 }, (_, i) => {
    const d = new Date(weekStart);
    d.setDate(weekStart.getDate() + i);
    return d;
  });

  const navigateWeek = (direction) => {
    const newDate = new Date(weekStart);
    newDate.setDate(weekStart.getDate() + (direction * 7));
    if (newDate >= minWeekStart && newDate <= maxWeekStart) {
      setWeekStart(newDate);
    }
  };

  /**
   * Tính tọa độ pixel từ thời gian thực, dựa trên vị trí từng period trong session.
   * Giải quyết vấn đề gaps giữa các period (ví dụ: 9:45-10:00 nghỉ giải lao).
   * @param {number} timeHour - Giờ dạng số thực (ví dụ 10.733 = 10h44)
   * @param {Array} sessionPeriods - Danh sách các period trong session
   * @returns {number} Pixel offset từ đầu session container
   */
  const timeToPixel = (timeHour, sessionPeriods) => {
    let pixelOffset = 0;
    for (let i = 0; i < sessionPeriods.length; i++) {
      const p = sessionPeriods[i];
      if (timeHour <= p.start) {
        // Thời gian nằm trước period này → trả về offset hiện tại
        return pixelOffset;
      }
      if (timeHour >= p.end) {
        // Thời gian nằm sau period này → cộng hết chiều cao period
        pixelOffset += SLOT_HEIGHT;
      } else {
        // Thời gian nằm TRONG period này → nội suy tuyến tính
        const fraction = (timeHour - p.start) / (p.end - p.start);
        pixelOffset += fraction * SLOT_HEIGHT;
        return pixelOffset;
      }
    }
    return pixelOffset; // Nếu vượt quá tất cả period
  };

  /**
   * Tính toán hình học cho Task Block (Absolute Positioning)
   * @param {Object} task 
   * @param {string} session 'Morning' | 'Afternoon'
   * @returns {Object|null} { top, height }
   */
  const calculateTaskGeometry = (task, session, currentDate) => {
    const taskStart = new Date(task.ThoiGianBatDau);
    const taskEnd = task.ThoiGianKetThuc ? new Date(task.ThoiGianKetThuc) : taskStart;
    
    // Normalize dates to check for day overlap
    const d = new Date(currentDate); d.setHours(0,0,0,0);
    const s = new Date(taskStart); s.setHours(0,0,0,0);
    const e = new Date(taskEnd); e.setHours(0,0,0,0);

    let startHour, endHour;

    // Start hour logic
    if (d > s) {
      startHour = 0; // Starts before today
    } else {
      startHour = taskStart.getHours() + (taskStart.getMinutes() / 60);
    }

    // End hour logic
    if (d < e) {
      endHour = 24; // Ends after today
    } else {
      endHour = taskEnd.getHours() + (taskEnd.getMinutes() / 60);
    }
    
    const sessionPeriods = PERIODS.filter(p => p.session === session);
    if (sessionPeriods.length === 0) return null;

    const sessionTimeStart = sessionPeriods[0].start;
    const sessionTimeEnd = sessionPeriods[sessionPeriods.length - 1].end;
    
    // Nếu task hoàn toàn nằm ngoài session → không vẽ
    if (startHour >= sessionTimeEnd || endHour <= sessionTimeStart) return null;

    const clampedStart = Math.max(startHour, sessionTimeStart);
    const clampedEnd = Math.min(endHour, sessionTimeEnd);
    if (clampedEnd <= clampedStart) return null;

    const top = timeToPixel(clampedStart, sessionPeriods);
    const bottom = timeToPixel(clampedEnd, sessionPeriods);
    const height = bottom - top;

    if (height < 2) return null; // Quá nhỏ để hiển thị

    return { top, height };
  };

  const getTasksForDay = (date) => {
    return tasks.filter(t => {
      const start = new Date(t.ThoiGianBatDau);
      const end = t.ThoiGianKetThuc ? new Date(t.ThoiGianKetThuc) : start;
      
      // Đưa về 0h để so sánh ngày
      const d = new Date(date);
      d.setHours(0, 0, 0, 0);
      const s = new Date(start);
      s.setHours(0, 0, 0, 0);
      const e = new Date(end);
      e.setHours(0, 0, 0, 0);
      
      return d >= s && d <= e;
    });
  };

  return (
    <div className="academic-timetable">
      <div className="timetable-header">
        <div className="header-left">
          <h3>Lịch Hoạt Động Tuần</h3>
          <span className="date-range">
            {weekDates[0].toLocaleDateString('vi-VN')} - {weekDates[6].toLocaleDateString('vi-VN')}
          </span>
        </div>
        <div className="timetable-nav">
          <button onClick={() => navigateWeek(-1)} className="nav-btn" disabled={weekStart.getTime() <= minWeekStart.getTime()}>Tuần trước</button>
          <button onClick={() => navigateWeek(1)} className="nav-btn" disabled={weekStart.getTime() >= maxWeekStart.getTime()}>Tuần sau</button>
        </div>
      </div>

      <div className="grid-wrapper">
        <table className="tkb-table">
          <thead>
            <tr>
              <th className="sticky-col">Thời gian</th>
              {daysShort.map((day, idx) => (
                <th key={idx}>
                  <div className="th-content">
                    <span className="day-label">{day} ({weekDates[idx].getDate()}/{weekDates[idx].getMonth() + 1})</span>
                  </div>
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {PERIODS.map((period, pIdx) => (
              <tr key={period.id} style={{ height: `${SLOT_HEIGHT}px` }}>
                <td className="period-info sticky-col">
                  <div className="p-time">{period.time}</div>
                </td>
                
                {/* Chỉ vẽ overlay relative ở hàng đầu tiên của mỗi session */}
                {weekDates.map((date, dIdx) => {
                  // Kiểm tra xem đây có phải là Tiết đầu tiên của session (Tiết 1 hoặc Tiết 6)
                  const isSessionStart = (period.id === 1 || period.id === 6);
                  
                  if (!isSessionStart) return null; 

                  // Tính tổng số tiết trong session này để set chiều cao cho container relative
                  const sessionPeriods = PERIODS.filter(p => p.session === period.session);
                  const containerHeight = sessionPeriods.length * SLOT_HEIGHT;
                  const dayTasks = getTasksForDay(date);

                  return (
                    <td key={dIdx} className="tkb-cell session-cell" rowSpan={sessionPeriods.length}>
                      <div className="session-relative-container" style={{ height: `${containerHeight}px` }}>
                        {dayTasks.map(task => {
                          const geo = calculateTaskGeometry(task, period.session, date);
                          if (!geo) return null;
                          const color = COLORS[(task.MaCongViec.slice(-1).charCodeAt(0)) % COLORS.length];
                          return (
                            <TaskBlock 
                              key={task.MaCongViec}
                              task={task}
                              top={geo.top}
                              height={geo.height}
                              color={color}
                              readOnly={readOnly}
                              onClick={onTaskClick}
                            />
                          );
                        })}
                      </div>
                    </td>
                  );
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default TimetableGrid;


