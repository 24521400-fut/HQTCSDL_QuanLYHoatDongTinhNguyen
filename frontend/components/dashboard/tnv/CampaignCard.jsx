import React from 'react';
import { useNavigate } from 'react-router-dom';
import './CampaignCard.css';

const CampaignCard = ({ campaign }) => {
  const navigate = useNavigate();

  const handleCardClick = () => {
    // Navigate to campaign details
    navigate(`/volunteer/campaigns/${campaign.id}`);
  };

  return (
    <div className="glass-campaign-card" onClick={handleCardClick}>
      <div className="card-header">
        <h3>{campaign.name}</h3>
      </div>
      <div className="card-body">
        <p><strong>Người Điều Hành:</strong> {campaign.coordinator}</p>
        <p><strong>Vai Trò Của Bạn:</strong> {campaign.role}</p>
      </div>
    </div>
  );
};

export default CampaignCard;
