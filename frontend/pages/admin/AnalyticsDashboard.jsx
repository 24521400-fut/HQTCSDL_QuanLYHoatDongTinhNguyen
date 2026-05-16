import React, { useState, useEffect } from "react";
import MainLayout from "../../components/layout/MainLayout";
import GlassCard from "../../components/common/GlassCard";
import { getCampaigns } from "../../services/campaigns";
import { getCampaignStats, getTopVolunteers } from "../../services/statistics";
import { 
  Chart as ChartJS, 
  CategoryScale, 
  LinearScale, 
  BarElement, 
  Title, 
  Tooltip, 
  Legend 
} from 'chart.js';
import { Bar } from 'react-chartjs-2';
import "./AnalyticsDashboard.css";

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

const AnalyticsDashboard = () => {
  const [campaigns, setCampaigns] = useState([]);
  const [selectedCampaign, setSelectedCampaign] = useState("");
  const [stats, setStats] = useState({ income: 0, expense: 0, weekly: [] });
  const [topTNV, setTopTNV] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchInitialData();
  }, []);

  useEffect(() => {
    if (selectedCampaign) {
      fetchCampaignData(selectedCampaign);
    }
  }, [selectedCampaign]);

  const fetchInitialData = async () => {
    try {
      const data = await getCampaigns();
      setCampaigns(data);
      if (data.length > 0) {
        setSelectedCampaign(data[0].MaChienDich || data[0].MACHIENDICH);
      }
    } catch (error) {
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const fetchCampaignData = async (id) => {
    try {
      const [s, top] = await Promise.all([
        getCampaignStats(id),
        getTopVolunteers(id)
      ]);
      setStats(s || { income: 0, expense: 0, weekly: [] });
      setTopTNV(top || []);
    } catch (error) {
      console.error(error);
    }
  };

  const chartData = {
    labels: stats.weekly && stats.weekly.length > 0 ? stats.weekly.map(w => w.week) : ['Tài chính (VNĐ)'],
    datasets: [
      {
        label: 'Tổng Thu (Tài trợ & Quyên góp)',
        data: stats.weekly && stats.weekly.length > 0 ? stats.weekly.map(w => w.income) : [stats.income],
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        borderColor: 'rgb(75, 192, 192)',
        borderWidth: 1,
      },
      {
        label: 'Tổng Chi (Kế hoạch & Phát sinh)',
        data: stats.weekly && stats.weekly.length > 0 ? stats.weekly.map(w => w.expense) : [stats.expense],
        backgroundColor: 'rgba(255, 99, 132, 0.6)',
        borderColor: 'rgb(255, 99, 132)',
        borderWidth: 1,
      }
    ],
  };

  const formatHours = (hours) => {
    if (!hours && hours !== 0) return '0h';
    const h = Math.floor(hours);
    const m = Math.round((hours - h) * 60);
    if (m === 0) return `${h}h`;
    return `${h}h ${m}p`;
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: { position: 'top' },
      title: { display: false }
    },
    scales: {
      y: { beginAtZero: true }
    }
  };

  return (
    <MainLayout>
      <div className="analytics-container">
        <header className="analytics-header">
          <div className="header-info">
            <h1>Báo cáo & Thống kê</h1>
            <p>Phân tích hiệu quả chiến dịch và vinh danh tình nguyện viên</p>
          </div>
          <div className="campaign-selector">
            <label>Chọn chiến dịch:</label>
            <select value={selectedCampaign} onChange={(e) => setSelectedCampaign(e.target.value)}>
              {campaigns.map(c => (
                <option key={c.MaChienDich || c.MACHIENDICH} value={c.MaChienDich || c.MACHIENDICH}>
                  {c.TenChienDich || c.TENCHIENDICH}
                </option>
              ))}
            </select>
          </div>
        </header>

        {loading ? (
          <div className="loading">Đang tải dữ liệu...</div>
        ) : (
          <div className="analytics-grid">
            {/* Chart Section */}
            <GlassCard title="Hiệu quả Tài chính" className="chart-card">
              <div className="chart-wrapper">
                <Bar data={chartData} options={chartOptions} />
              </div>
              <div className="finance-summary">
                <div className="summary-item">
                  <span className="label">Số dư hiện tại:</span>
                  <span className={`value ${(stats.income - stats.expense) >= 0 ? 'plus' : 'minus'}`}>
                    {(stats.income - stats.expense).toLocaleString()} VNĐ
                  </span>
                </div>
              </div>
            </GlassCard>

            {/* Hall of Fame */}
            <GlassCard title="Bảng Vàng Tình Nguyện" className="hall-of-fame">
              <div className="top-tnv-list">
                {topTNV.length > 0 ? (
                  topTNV.map((tnv, index) => (
                    <div key={tnv.MaTaiKhoan || tnv.MATAIKHOAN} className="tnv-rank-item">
                      <div className="rank-badge">{index + 1}</div>
                      <div className="tnv-info">
                        <span className="tnv-name">{tnv.HoTen || tnv.HOTEN}</span>
                        <span className="tnv-stats">
                          {formatHours(tnv.TongGio || tnv.TONGGIO || 0)} • {tnv.DiemDanhGia || tnv.DIEMDANHGIA || 0}đ • {tnv.XepLoai || tnv.XEPLOAI}
                        </span>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="empty-state">Chưa có dữ liệu đánh giá cho chiến dịch này.</div>
                )}
              </div>
            </GlassCard>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default AnalyticsDashboard;
