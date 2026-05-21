import React, { useState, useEffect } from "react";
import MainLayout from "../../components/layout/MainLayout";
import GlassCard from "../../components/common/GlassCard";
import SystemModal from "../../components/common/SystemModal";
import { getAllPartners, addPartner, recordSponsorship } from "../../services/partners";
import { getCampaigns } from "../../services/campaigns";
import "./PartnerManagementPage.css";

const PartnerManagementPage = () => {
  const [partners, setPartners] = useState([]);
  const [campaigns, setCampaigns] = useState([]);
  const [loading, setLoading] = useState(true);
  const [modal, setModal] = useState({ isOpen: false, title: "", message: "", type: "info" });

  const [partnerForm, setPartnerForm] = useState({
    tenDoiTac: "",
    linhVuc: "",
    soDienThoai: "",
    email: "",
    diaChi: "",
    nguoiDaiDien: ""
  });

  const [sponsorForm, setSponsorForm] = useState({
    maDoiTac: "",
    maChienDich: "",
    loaiTaiTro: "TienMat",
    giaTriTaiTro: ""
  });

  useEffect(() => {
    fetchInitialData();
  }, []);

  const fetchInitialData = async () => {
    try {
      const [partnerData, campData] = await Promise.all([
        getAllPartners(),
        getCampaigns()
      ]);
      setPartners(partnerData);
      setCampaigns(campData);
      
      if (partnerData.length > 0) {
        setSponsorForm(prev => ({ ...prev, maDoiTac: partnerData[0].MaDoiTac || partnerData[0].MADOITAC }));
      }
      if (campData.length > 0) {
        setSponsorForm(prev => ({ ...prev, maChienDich: campData[0].MaChienDich || campData[0].MACHIENDICH }));
      }
    } catch (error) {
      console.error("Lỗi khi tải dữ liệu:", error);
    } finally {
      setLoading(false);
    }
  };

  const handlePartnerSubmit = async (e) => {
    e.preventDefault();
    try {
      await addPartner(partnerForm);
      setModal({ isOpen: true, title: "Thành công", message: "Đã thêm đối tác thành công.", type: "success" });
      setPartnerForm({ tenDoiTac: "", linhVuc: "", soDienThoai: "", email: "", diaChi: "", nguoiDaiDien: "" });
      fetchInitialData(); // Refresh list
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const handleSponsorSubmit = async (e) => {
    e.preventDefault();
    try {
      await recordSponsorship({
        ...sponsorForm,
        giaTriTaiTro: Number(sponsorForm.giaTriTaiTro)
      });
      setModal({ isOpen: true, title: "Thành công", message: "Ký kết tài trợ thành công! Quỹ đã được cập nhật.", type: "success" });
      setSponsorForm({ ...sponsorForm, giaTriTaiTro: "" });
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  return (
    <MainLayout>
      <SystemModal 
        isOpen={modal.isOpen} 
        title={modal.title} 
        message={modal.message} 
        type={modal.type} 
        onClose={() => setModal({ ...modal, isOpen: false })} 
      />

      <div className="partner-page-container">
        <header className="page-header">
          <div className="header-info">
            <h1>Quản lý Đối tác & Ký kết tài trợ</h1>
            <p>Thêm mới tổ chức/cá nhân tài trợ và lập hồ sơ hợp đồng tài trợ cho chiến dịch.</p>
          </div>
        </header>

        {loading ? (
          <div className="loading-spinner">Đang tải dữ liệu...</div>
        ) : (
          <div className="partner-layout">
            {/* Left Column: Partners List & Add Partner */}
            <div className="partner-left-col">
              <GlassCard title="Thêm Đối tác Mới" className="mb-4">
                <form onSubmit={handlePartnerSubmit} className="partner-form">
                  <div className="form-group">
                    <label>Tên Đối Tác / Đơn Vị *</label>
                    <input type="text" required value={partnerForm.tenDoiTac} onChange={e => setPartnerForm({...partnerForm, tenDoiTac: e.target.value})} placeholder="VD: Công ty TNHH Phần mềm ABC" />
                  </div>
                  <div className="form-group-row">
                    <div className="form-group">
                      <label>Email *</label>
                      <input type="email" required value={partnerForm.email} onChange={e => setPartnerForm({...partnerForm, email: e.target.value})} placeholder="abc@gmail.com" />
                    </div>
                    <div className="form-group">
                      <label>Số điện thoại</label>
                      <input type="tel" value={partnerForm.soDienThoai} onChange={e => setPartnerForm({...partnerForm, soDienThoai: e.target.value})} placeholder="0909..." />
                    </div>
                  </div>
                  <div className="form-group-row">
                    <div className="form-group">
                      <label>Lĩnh vực</label>
                      <input type="text" value={partnerForm.linhVuc} onChange={e => setPartnerForm({...partnerForm, linhVuc: e.target.value})} placeholder="VD: Công nghệ" />
                    </div>
                    <div className="form-group">
                      <label>Người đại diện</label>
                      <input type="text" value={partnerForm.nguoiDaiDien} onChange={e => setPartnerForm({...partnerForm, nguoiDaiDien: e.target.value})} placeholder="VD: Nguyễn Văn A" />
                    </div>
                  </div>
                  <div className="form-group">
                    <label>Địa chỉ</label>
                    <input type="text" value={partnerForm.diaChi} onChange={e => setPartnerForm({...partnerForm, diaChi: e.target.value})} placeholder="Địa chỉ trụ sở" />
                  </div>
                  <button type="submit" className="action-btn success-btn">Thêm Đối Tác</button>
                </form>
              </GlassCard>

              <GlassCard title={`Danh Sách Đối Tác (${partners.length})`}>
                <div className="table-responsive">
                  <table className="partner-table">
                    <thead>
                      <tr>
                        <th>Mã ĐT</th>
                        <th>Tên Đối Tác</th>
                        <th>Lĩnh Vực</th>
                        <th>Liên Hệ</th>
                      </tr>
                    </thead>
                    <tbody>
                      {partners.length > 0 ? (
                        partners.map(p => (
                          <tr key={p.MaDoiTac || p.MADOITAC}>
                            <td className="code-badge">{p.MaDoiTac || p.MADOITAC}</td>
                            <td>{p.TenDoiTac || p.TENDOITAC}</td>
                            <td>{p.LinhVuc || p.LINHVUC || '-'}</td>
                            <td>
                              {p.Email || p.EMAIL}<br/>
                              <small>{p.SoDienThoai || p.SODIENTHOAI}</small>
                            </td>
                          </tr>
                        ))
                      ) : (
                        <tr><td colSpan="4" className="text-center">Chưa có đối tác nào.</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </GlassCard>
            </div>

            {/* Right Column: Sponsorship Contract */}
            <div className="partner-right-col">
              <GlassCard title="Ký Kết Hợp Đồng Tài Trợ">
                <form onSubmit={handleSponsorSubmit} className="partner-form sponsor-form">
                  <div className="form-group">
                    <label>Chọn Đối Tác</label>
                    <select value={sponsorForm.maDoiTac} onChange={e => setSponsorForm({...sponsorForm, maDoiTac: e.target.value})}>
                      {partners.map(p => (
                        <option key={p.MaDoiTac || p.MADOITAC} value={p.MaDoiTac || p.MADOITAC}>
                          {p.TenDoiTac || p.TENDOITAC}
                        </option>
                      ))}
                    </select>
                  </div>
                  
                  <div className="form-group">
                    <label>Tài trợ cho Chiến dịch</label>
                    <select value={sponsorForm.maChienDich} onChange={e => setSponsorForm({...sponsorForm, maChienDich: e.target.value})}>
                      {campaigns.map(c => (
                        <option key={c.MaChienDich || c.MACHIENDICH} value={c.MaChienDich || c.MACHIENDICH}>
                          {c.TenChienDich || c.TENCHIENDICH}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="form-group-row">
                    <div className="form-group">
                      <label>Hình Thức</label>
                      <select value={sponsorForm.loaiTaiTro} onChange={e => setSponsorForm({...sponsorForm, loaiTaiTro: e.target.value})}>
                        <option value="TienMat">Tiền Mặt / Chuyển khoản</option>
                        <option value="HienVat">Hiện Vật</option>
                      </select>
                    </div>
                    <div className="form-group">
                      <label>Giá Trị (VNĐ)</label>
                      <input type="number" min="1000" required value={sponsorForm.giaTriTaiTro} onChange={e => setSponsorForm({...sponsorForm, giaTriTaiTro: e.target.value})} placeholder="VD: 50000000" />
                    </div>
                  </div>
                  
                  <div className="form-info-box">
                    <strong>Lưu ý:</strong> Khi ký kết tài trợ Tiền Mặt, hệ thống sẽ tự động cập nhật số dư vào ngân quỹ chung của Chiến dịch (Bạn có thể kiểm tra tại tab Tài trợ & Quyên góp).
                  </div>

                  <button type="submit" className="action-btn success-btn full-width mt-3">Ghi Nhận Tài Trợ</button>
                </form>
              </GlassCard>
            </div>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default PartnerManagementPage;
