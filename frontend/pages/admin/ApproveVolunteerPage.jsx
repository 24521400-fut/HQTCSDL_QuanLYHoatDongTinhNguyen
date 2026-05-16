import React, { useState, useEffect } from "react";
import MainLayout from "../../components/layout/MainLayout";
import GlassCard from "../../components/common/GlassCard";
import SystemModal from "../../components/common/SystemModal";
import { getAllAccounts, updateAccountStatus, deleteAccount, createAccount } from "../../services/admin";
import "./AccountManagement.css";

const ApproveVolunteerPage = () => {
  const [accounts, setAccounts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [modal, setModal] = useState({ isOpen: false, title: "", message: "", type: "info" });
  const [deleteConfirm, setDeleteConfirm] = useState({ isOpen: false, maTK: null });
  const [createModal, setCreateModal] = useState({ 
    isOpen: false, 
    formData: { tenDangNhap: "", matKhau: "", email: "", vaiTro: "TinhNguyenVien", hoTen: "", mssv: "" } 
  });

  const fetchAccounts = async () => {
    try {
      setLoading(true);
      const data = await getAllAccounts();
      setAccounts(data);
    } catch (error) {
      console.error(error);
      setModal({ isOpen: true, title: "Lỗi", message: "Không thể tải danh sách tài khoản", type: "error" });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchAccounts();
  }, []);

  const handleToggleStatus = async (maTK, currentStatus) => {
    const newStatus = currentStatus === 'HoatDong' ? 'Khoa' : 'HoatDong';
    try {
      await updateAccountStatus(maTK, newStatus);
      setModal({ 
        isOpen: true, 
        title: "Thành công", 
        message: `Đã ${newStatus === 'Khoa' ? 'khóa' : 'mở khóa'} tài khoản ${maTK}`, 
        type: "success" 
      });
      fetchAccounts();
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const confirmDelete = async () => {
    try {
      await deleteAccount(deleteConfirm.maTK);
      setModal({ isOpen: true, title: "Thành công", message: `Đã xóa vĩnh viễn tài khoản ${deleteConfirm.maTK} và mọi dữ liệu liên quan.`, type: "success" });
      setDeleteConfirm({ isOpen: false, maTK: null });
      fetchAccounts();
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const handleCreateSubmit = async (e) => {
    e.preventDefault();
    try {
      await createAccount(createModal.formData);
      setModal({ isOpen: true, title: "Thành công", message: `Đã tạo tài khoản ${createModal.formData.tenDangNhap} thành công.`, type: "success" });
      setCreateModal({ ...createModal, isOpen: false, formData: { tenDangNhap: "", matKhau: "", email: "", vaiTro: "TinhNguyenVien", hoTen: "", mssv: "" } });
      fetchAccounts();
    } catch (error) {
      setModal({ isOpen: true, title: "Lỗi", message: error.message, type: "error" });
    }
  };

  const filteredAccounts = accounts.filter(acc => 
    acc.MaTaiKhoan.toLowerCase().includes(searchTerm.toLowerCase()) ||
    acc.TenDangNhap.toLowerCase().includes(searchTerm.toLowerCase()) ||
    (acc.HoTen && acc.HoTen.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  return (
    <MainLayout>
      <div className="account-mgmt-container">
        <header className="page-header">
          <h1 className="gradient-text">Quản trị tài khoản</h1>
          <p className="subtitle">Quản lý trạng thái hoạt động của toàn bộ tài khoản trong hệ thống</p>
        </header>

        <GlassCard className="mgmt-card">
          <div className="search-bar-row">
            <input 
              type="text" 
              placeholder="Tìm kiếm theo mã tài khoản, tên đăng nhập..." 
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="search-input"
            />
            <button 
              className="action-btn create-new-btn"
              onClick={() => setCreateModal({ ...createModal, isOpen: true })}
            >
              + Tạo tài khoản mới
            </button>
            <div className="account-count">
              Tổng số: <strong>{accounts.length}</strong>
            </div>
          </div>

          <div className="table-responsive">
            <table className="custom-table">
              <thead>
                <tr>
                  <th>Mã TK</th>
                  <th>Tên đăng nhập</th>
                  <th>Họ Tên / MSSV</th>
                  <th>Vai Trò</th>
                  <th className="text-center">Trạng Thái</th>
                  <th className="text-center">Thao Tác</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr><td colSpan="6" className="text-center">Đang tải...</td></tr>
                ) : filteredAccounts.length === 0 ? (
                  <tr><td colSpan="6" className="text-center">Không tìm thấy tài khoản nào.</td></tr>
                ) : filteredAccounts.map(acc => (
                  <tr key={acc.MaTaiKhoan}>
                    <td><span className="id-tag">{acc.MaTaiKhoan}</span></td>
                    <td><strong>{acc.TenDangNhap}</strong></td>
                    <td>
                      <div className="user-info">
                        <strong>{acc.HoTen || 'N/A'}</strong>
                        {acc.MSSV && <small className="mssv-small">MSSV: {acc.MSSV}</small>}
                      </div>
                    </td>
                    <td><span className={`role-badge ${acc.VaiTro}`}>{acc.VaiTro}</span></td>
                    <td className="text-center">
                      <span className={`status-badge ${acc.TrangThai}`}>
                        {acc.TrangThai === 'HoatDong' ? 'Đang hoạt động' : 'Bị khóa'}
                      </span>
                    </td>
                    <td className="text-center">
                      <div className="action-group">
                        <button 
                          className={`action-btn ${acc.TrangThai === 'HoatDong' ? 'lock' : 'unlock'}`}
                          onClick={() => handleToggleStatus(acc.MaTaiKhoan, acc.TrangThai)}
                          disabled={acc.VaiTro === 'BanQuanLy'}
                          title={acc.VaiTro === 'BanQuanLy' ? "Không thể thao tác với tài khoản Admin" : ""}
                        >
                          {acc.TrangThai === 'HoatDong' ? 'Khóa' : 'Mở khóa'}
                        </button>
                        <button 
                          className="action-btn delete-btn"
                          onClick={() => setDeleteConfirm({ isOpen: true, maTK: acc.MaTaiKhoan })}
                          disabled={acc.VaiTro === 'BanQuanLy'}
                          title={acc.VaiTro === 'BanQuanLy' ? "Không thể xóa tài khoản Admin" : ""}
                        >
                          Xóa
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </GlassCard>
      </div>

      <SystemModal 
        isOpen={modal.isOpen}
        title={modal.title}
        message={modal.message}
        type={modal.type}
        onClose={() => setModal({ ...modal, isOpen: false })}
      />

      <SystemModal 
        isOpen={deleteConfirm.isOpen}
        title="Xác nhận xóa"
        message={`Bạn có chắc chắn muốn xóa vĩnh viễn tài khoản ${deleteConfirm.maTK}? Hành động này KHÔNG THỂ hoàn tác và sẽ xóa sạch mọi thông tin liên quan.`}
        type="confirm"
        onClose={() => setDeleteConfirm({ isOpen: false, maTK: null })}
        onConfirm={confirmDelete}
      />

      <SystemModal 
        isOpen={createModal.isOpen}
        title="Tạo tài khoản mới"
        type="custom"
        onClose={() => setCreateModal({ ...createModal, isOpen: false })}
      >
        <form onSubmit={handleCreateSubmit} className="create-account-form">
          <div className="form-grid">
            <div className="form-group">
              <label>Tên đăng nhập</label>
              <input 
                type="text" required
                value={createModal.formData.tenDangNhap}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, tenDangNhap: e.target.value } })}
              />
            </div>
            <div className="form-group">
              <label>Mật khẩu</label>
              <input 
                type="password" required
                value={createModal.formData.matKhau}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, matKhau: e.target.value } })}
              />
            </div>
            <div className="form-group">
              <label>Email</label>
              <input 
                type="email" required
                value={createModal.formData.email}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, email: e.target.value } })}
              />
            </div>
            <div className="form-group">
              <label>Vai trò</label>
              <select 
                value={createModal.formData.vaiTro}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, vaiTro: e.target.value } })}
              >
                <option value="TinhNguyenVien">Tình nguyện viên</option>
                <option value="BanDieuHanh">Ban điều hành</option>
                <option value="BanQuanLy">Ban quản lý</option>
              </select>
            </div>
            <div className="form-group">
              <label>Họ tên</label>
              <input 
                type="text" required
                value={createModal.formData.hoTen}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, hoTen: e.target.value } })}
              />
            </div>
            <div className="form-group">
              <label>MSSV</label>
              <input 
                type="text"
                value={createModal.formData.mssv}
                onChange={(e) => setCreateModal({ ...createModal, formData: { ...createModal.formData, mssv: e.target.value } })}
              />
            </div>
          </div>
          <div className="form-actions">
            <button type="button" className="btn-cancel" onClick={() => setCreateModal({ ...createModal, isOpen: false })}>Hủy</button>
            <button type="submit" className="btn-submit">Tạo tài khoản</button>
          </div>
        </form>
      </SystemModal>
    </MainLayout>
  );
};

export default ApproveVolunteerPage;
