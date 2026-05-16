import React from 'react';
import './TaskBlock.css';

const TaskBlock = ({ task, top, height, color, onClick, readOnly }) => {
  const formatTime = (dateStr) => {
    const d = new Date(dateStr);
    return `${d.getHours().toString().padStart(2, '0')}:${d.getMinutes().toString().padStart(2, '0')}`;
  };

  const startTime = formatTime(task.ThoiGianBatDau);
  const endTime = task.ThoiGianKetThuc ? formatTime(task.ThoiGianKetThuc) : '';
  const volNeeded = task.SoLuongTNVCan || task.SOLUONGTNVCAN || 0;
  const volAssigned = task.DaPhanCong || 0;

  return (
    <div 
      className="task-block"
      style={{ 
        top: `${top}px`, 
        height: `${Math.max(height, 30)}px`,
        borderLeftColor: color,
      }}
      onClick={() => !readOnly && onClick && onClick(task)}
      title={`${task.TenCongViec}\n${startTime} - ${endTime}\nTNV: ${volAssigned}/${volNeeded}`}
    >
      <div className="task-block-inner">
        <span className="task-block-name">{task.TenCongViec}</span>
        <span className="task-block-time">{startTime} - {endTime}</span>
        <span className="task-block-vol">👥 {volAssigned}/{volNeeded}</span>
      </div>
    </div>
  );
};

export default TaskBlock;
