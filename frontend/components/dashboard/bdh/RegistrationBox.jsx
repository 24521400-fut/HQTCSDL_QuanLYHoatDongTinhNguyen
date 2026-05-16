import React from 'react';

const RegistrationBox = ({ registrations, onApprove, onReject, personnelCount }) => {
  return (
    <div className="utility-box registration-box">
      <div className="box-header">
        <h4>Yêu cầu tham gia ({registrations.length})</h4>
        {personnelCount && (
          <span className="personnel-count-line">
            TNV đã duyệt: {personnelCount.APPROVED} / {personnelCount.TARGET}
          </span>
        )}
      </div>
      <div className="box-content scrollable">
        {registrations.length === 0 ? (
          <div className="empty-state">Không có yêu cầu mới.</div>
        ) : (
          registrations.map(reg => (
            <div key={reg.MATHAMGIA || reg.MaThamGia} className="reg-item">
              <div className="reg-info">
                <strong>{reg.HOTEN || reg.HoTen}</strong>
                <span>{reg.MSSV || reg.MaSinhVien} - {reg.LOP || reg.Lop}</span>
              </div>
              <div className="reg-actions">
                <button className="btn-approve-small" onClick={() => onApprove(reg.MATHAMGIA || reg.MaThamGia)}>✓</button>
                <button className="btn-reject-small" onClick={() => onReject(reg.MATHAMGIA || reg.MaThamGia)}>✕</button>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default RegistrationBox;
