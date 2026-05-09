import { useEffect, useState } from "react";
import { getDanhSachDiemDanh } from "../services/tauriApi";

/**
 * AttendancePage — Trang điểm danh tình nguyện viên
 *
 * Chức năng:
 * - Hiển thị danh sách điểm danh theo chiến dịch
 * - Thực hiện điểm danh (check-in/check-out)
 * - Xem lịch sử điểm danh
 *
 * Quy tắc:
 * - Gọi backend qua services/tauriApi.js
 * - Xử lý loading state và error state
 */
function AttendancePage() {
  const [records, setRecords] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    getDanhSachDiemDanh()
      .then((data) => {
        setRecords(data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.toString());
        setLoading(false);
      });
  }, []);

  if (loading) return <div className="container"><p>Đang tải dữ liệu...</p></div>;
  if (error) return <div className="container"><p style={{ color: "var(--color-danger)" }}>Lỗi: {error}</p></div>;

  return (
    <div className="container">
      <h1>Điểm Danh Tình Nguyện Viên</h1>
      {/* TODO: Render bảng điểm danh */}
      <p>Tổng số bản ghi: {records.length}</p>
    </div>
  );
}

export default AttendancePage;
