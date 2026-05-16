import React, { useEffect, useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { Link } from 'react-router-dom';
import MainLayout from '../../components/layout/MainLayout';
import CampaignCard from '../../components/dashboard/tnv/CampaignCard';
import GlassCalendar from '../../components/dashboard/tnv/GlassCalendar';
import './DashboardTNV.css';

const API_URL = 'http://localhost:3000/api';

const DashboardTNV = () => {
  const { user } = useAuth();
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentNotifIndex, setCurrentNotifIndex] = useState(0);
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

  // Auto-slide notification
  useEffect(() => {
    if (!summary?.notifications?.length) return;
    
    const interval = setInterval(() => {
      setCurrentNotifIndex(prev => (prev + 1) % summary.notifications.length);
    }, 5000);
    
    return () => clearInterval(interval);
  }, [summary]);

  const handleAddPersonalEvent = async (eventData) => {
    try {
      const username = user?.TenDangNhap || user?.tenDangNhap;
      const response = await fetch(`${API_URL}/tnv/custom-events/${username}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(eventData)
      });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error);
      
      // Refresh summary to see the new event
      fetchSummary();
    } catch (err) {
      alert('Lỗi thêm sự kiện: ' + err.message);
    }
  };

  if (loading) return (
    <MainLayout>
      <div className="global-loading-container page-transition">
        <div className="spinner"></div>
        <p>Đang tải trang...</p>
      </div>
    </MainLayout>
  );
  if (error) return <MainLayout><div className="error-state page-transition">Lỗi: {error}</div></MainLayout>;

  const filteredCampaigns = summary?.activeCampaigns?.filter(camp => 
    camp.name.toLowerCase().includes(searchQuery.toLowerCase())
  ) || [];

  return (
    <MainLayout>
      <div className="tnv-dashboard-layout">
        <div className="tnv-main-content">
        
        {/* Campaign List */}
        <div className="campaign-list-section">
          <h2>Chiến Dịch Đang Tham Gia</h2>
          <div className="search-bar-container" style={{ position: 'relative' }}>
            <input 
              type="text" 
              placeholder="Tìm kiếm chiến dịch..." 
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
              <p>{searchQuery ? 'Không tìm thấy chiến dịch phù hợp.' : 'Bạn chưa tham gia chiến dịch nào.'}</p>
            )}
          </div>
        </div>
      </div>

      <div className="tnv-sidebar">
        <h2>Lịch Hoạt Động</h2>
        <GlassCalendar 
          attendanceDates={summary?.attendanceDates || []} 
          personalEvents={summary?.personalEvents || []} 
          onAddEvent={handleAddPersonalEvent} 
        />
      </div>
      </div>
    </MainLayout>
  );
};

export default DashboardTNV;
