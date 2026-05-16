import React from 'react';

const EvidenceBox = ({ evidence, onViewDetails, onBulkApprove }) => {
  return (
    <div className="utility-box evidence-box">
      <div className="box-header">
        <h4>Duyệt điểm danh ({evidence.length})</h4>
        {evidence.length > 0 && (
          <button className="btn-bulk-approve" onClick={onBulkApprove}>Duyệt tất cả</button>
        )}
      </div>
      <div className="box-content scrollable">
        {evidence.length === 0 ? (
          <div className="empty-state">Chưa có minh chứng nộp trong ngày.</div>
        ) : (
          evidence.map(item => (
            <div 
              key={item.MAMINHCHUNG || item.MaMinhChung} 
              className={`evidence-item ${(item.ISATTENDED || item.IsAttended) > 0 ? 'attended' : ''}`}
              onClick={() => onViewDetails(item)}
            >
              <div className="evidence-thumb">
                <img src={item.HINHANH_URL || item.HinhAnh_URL} alt="Evidence" />
              </div>
              <div className="evidence-info">
                <strong>{item.HOTEN || item.HoTen}</strong>
                <span>{item.LOAIMINHCHUNG || item.LoaiMinhChung}</span>
                <span className="evidence-date">
                  {(item.NGAYCAPNHAT || item.NgayCapNhat) ? new Date(item.NGAYCAPNHAT || item.NgayCapNhat).toLocaleTimeString('vi-VN', {hour: '2-digit', minute:'2-digit'}) : ''}
                </span>
              </div>
              {(item.ISATTENDED || item.IsAttended) > 0 && <div className="status-indicator">✓</div>}
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default EvidenceBox;
