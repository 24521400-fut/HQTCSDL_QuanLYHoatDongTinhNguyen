import React, { useEffect, useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { Link } from 'react-router-dom';
import MainLayout from '../../components/layout/MainLayout';
import CampaignCard from '../../components/dashboard/tnv/CampaignCard';
import '../tnv/DashboardTNV.css'; // Reuse dashboard styles

const API_URL = 'http://localhost:3000/api';

const HistoryPage = () => {
  const { user } = useAuth();
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');

  const fetchSummary = async () => {
    try {
      const username = user?.TenDangNhap || user?.tenDangNhap;
      if (!username) return;

      const response = await fetch(`${API_URL}/tnv/dashboard-summary/${username}`);
      const data = await response.json();
      
      if (!response.ok) throw new Error(data.error || 'Failed to fetch summary');
      
      setSummary(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSummary();
  }, [user]);

  if (loading) return (
    <MainLayout>
      <div className="global-loading-container page-transition">
        <div className="spinner"></div>
        <p>Đang tải trang...</p>
      </div>
    </MainLayout>
  );
  if (error) return <MainLayout><div className="error-state page-transition">Lỗi: {error}</div></MainLayout>;

  const filteredCampaigns = summary?.pastCampaigns?.filter(camp => 
    camp.name.toLowerCase().includes(searchQuery.toLowerCase())
  ) || [];

  return (
    <MainLayout>
      <div className="tnv-dashboard-layout" style={{ gridTemplateColumns: '1fr' }}>
        <div className="tnv-main-content">
        
        {/* Campaign List */}
        <div className="campaign-list-section">
          <h2>Lịch Sử Hoạt Động</h2>
          <p className="section-subtitle">Danh sách các chiến dịch bạn đã hoàn thành</p>
          
          <div className="search-bar-container" style={{ position: 'relative', maxWidth: '600px', marginBottom: '2rem' }}>
            <input 
              type="text" 
              placeholder="Tìm kiếm chiến dịch đã kết thúc..." 
              className="glass-search-input" 
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
            {searchQuery && (
              <button 
                onClick={() => setSearchQuery('')}
                className="clear-search-btn"
                title="Xóa tìm kiếm"
              >
                ✕
              </button>
            )}
          </div>
          
          <div className="campaign-cards">
            {filteredCampaigns.length > 0 ? (
              filteredCampaigns.map(camp => (
                <Link to={`/volunteer/campaigns/${camp.id}`} key={camp.id} style={{ textDecoration: 'none' }}>
                  <CampaignCard campaign={camp} />
                </Link>
              ))
            ) : (
              <div className="empty-state-container glass-panel" style={{ padding: '3rem', textAlign: 'center' }}>
                <p>{searchQuery ? 'Không tìm thấy chiến dịch phù hợp.' : 'Bạn chưa có chiến dịch nào đã kết thúc.'}</p>
              </div>
            )}
          </div>
        </div>
      </div>
      </div>
    </MainLayout>
  );
};

export default HistoryPage;
