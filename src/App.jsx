import { BrowserRouter, Routes, Route } from "react-router-dom";
import CampaignPage from "./pages/CampaignPage";
import AttendancePage from "./pages/AttendancePage";

/**
 * Root component của ứng dụng.
 * Khai báo tất cả routes tại đây.
 *
 * Quy tắc:
 * - Mỗi trang mới → thêm 1 <Route> tại đây
 * - Component trang nằm trong src/pages/
 * - KHÔNG viết logic nghiệp vụ trong App.jsx
 */
function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<CampaignPage />} />
        <Route path="/campaigns" element={<CampaignPage />} />
        <Route path="/attendance" element={<AttendancePage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
