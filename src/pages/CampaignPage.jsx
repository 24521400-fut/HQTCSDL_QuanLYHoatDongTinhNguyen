import { useEffect, useState } from "react";
import { getDanhSachChienDich } from "../services/tauriApi";

/**
 * CampaignPage — Trang quản lý chiến dịch tình nguyện
 *
 * Chức năng:
 * - Hiển thị danh sách chiến dịch
 * - Đăng ký tham gia chiến dịch
 * - Xem chi tiết chiến dịch
 *
 * Quy tắc:
 * - Gọi backend qua services/tauriApi.js, KHÔNG import invoke() trực tiếp
 * - Xử lý loading state và error state
 */
function CampaignPage() {
  const [campaigns, setCampaigns] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    getDanhSachChienDich()
      .then((data) => {
        setCampaigns(data);
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
      <h1>Quản Lý Chiến Dịch Tình Nguyện</h1>
      {/* TODO: Render danh sách chiến dịch */}
      <p>Tổng số chiến dịch: {campaigns.length}</p>
    </div>
  );
}

export default CampaignPage;
