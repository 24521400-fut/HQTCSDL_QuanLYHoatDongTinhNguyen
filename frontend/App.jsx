import { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "./context/AuthContext";

// Pages
import LoginPage from "./pages/common/LoginPage";
import RegisterPage from "./pages/common/RegisterPage";
import ForgotPasswordPage from "./pages/common/ForgotPasswordPage";
import ProfilePage from "./pages/common/ProfilePage";
import ThongBaoList from "./pages/common/ThongBaoList";
import MainLayout from "./components/layout/MainLayout";

import ApproveVolunteerPage from "./pages/admin/ApproveVolunteerPage";
import CreateCampaignPage from "./pages/admin/CreateCampaignPage";

import ApproveParticipationPage from "./pages/executive/ApproveParticipationPage";
import AttendancePage from "./pages/executive/AttendancePage";
import LogisticsPage from "./pages/executive/LogisticsPage";
import ProofReviewPage from "./pages/executive/ProofReviewPage";
import DashboardBDH from "./pages/executive/DashboardBDH";

import CampaignsPage from "./pages/volunteer/CampaignsPage";
import HistoryPage from "./pages/volunteer/HistoryPage";
import ProofUploadPage from "./pages/volunteer/ProofUploadPage";
import FinancePage from "./pages/admin/FinancePage";
import EvaluationPage from "./pages/executive/EvaluationPage";
import CertificationPage from "./pages/admin/CertificationPage";
import AnalyticsDashboard from "./pages/admin/AnalyticsDashboard";
import MyCertificatesPage from "./pages/volunteer/MyCertificatesPage";
import DashboardTNV from "./pages/tnv/DashboardTNV";
import TrangChiTietChienDich from "./pages/tnv/TrangChiTietChienDich";
import TaskDetailPage from "./pages/executive/TaskDetailPage";
import SponsorshipDonationPage from "./pages/admin/SponsorshipDonationPage";
import SystemConfigPage from "./pages/admin/SystemConfigPage";
import ExecutiveFinancePage from "./pages/executive/ExecutiveFinancePage";

const ProtectedRoute = ({ children, allowedRoles }) => {
  const { user } = useAuth();
  
  if (!user) {
    return <Navigate to="/login" replace />;
  }

  if (allowedRoles && !allowedRoles.includes(user.VaiTro)) {
    // If not allowed, send to appropriate default route based on role
    if (user.VaiTro === "BanQuanLy") return <Navigate to="/admin/approve-volunteer" replace />;
    if (user.VaiTro === "BanDieuHanh") return <Navigate to="/executive/dashboard" replace />;
    return <Navigate to="/volunteer/dashboard" replace />;
  }

  return children;
};

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />
          <Route path="/forgot-password" element={<ForgotPasswordPage />} />
          
          <Route path="/profile" element={
            <ProtectedRoute>
              <ProfilePage />
            </ProtectedRoute>
          } />
          
          <Route path="/notifications" element={
            <ProtectedRoute>
              <ThongBaoList />
            </ProtectedRoute>
          } />

          {/* Admin Routes */}
          <Route path="/admin/approve-volunteer" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <ApproveVolunteerPage />
            </ProtectedRoute>
          } />
          <Route path="/admin/create-campaign" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <CreateCampaignPage />
            </ProtectedRoute>
          } />
          <Route path="/admin/finance" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <SponsorshipDonationPage />
            </ProtectedRoute>
          } />
          <Route path="/admin/certification" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <CertificationPage />
            </ProtectedRoute>
          } />
          <Route path="/admin/analytics" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <AnalyticsDashboard />
            </ProtectedRoute>
          } />
          <Route path="/admin/config" element={
            <ProtectedRoute allowedRoles={["BanQuanLy"]}>
              <SystemConfigPage />
            </ProtectedRoute>
          } />

          {/* Executive Routes */}
          <Route path="/executive/dashboard" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <DashboardBDH />
            </ProtectedRoute>
          } />
          <Route path="/executive/approve-participation" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <ApproveParticipationPage />
            </ProtectedRoute>
          } />
          <Route path="/executive/attendance" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <AttendancePage />
            </ProtectedRoute>
          } />
          <Route path="/executive/logistics" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <LogisticsPage />
            </ProtectedRoute>
          } />
          <Route path="/executive/proof-review" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <ProofReviewPage />
            </ProtectedRoute>
          } />
          <Route path="/executive/evaluation" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <EvaluationPage />
            </ProtectedRoute>
          } />
          <Route path="/executive/finance" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <ExecutiveFinancePage />
            </ProtectedRoute>
          } />
          <Route path="/executive/task/:id" element={
            <ProtectedRoute allowedRoles={["BanDieuHanh"]}>
              <TaskDetailPage />
            </ProtectedRoute>
          } />

          {/* Volunteer Routes */}
          <Route path="/volunteer/dashboard" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <DashboardTNV />
            </ProtectedRoute>
          } />
          <Route path="/volunteer/campaigns" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <CampaignsPage />
            </ProtectedRoute>
          } />
          <Route path="/volunteer/campaigns/:id" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <TrangChiTietChienDich />
            </ProtectedRoute>
          } />
          <Route path="/volunteer/history" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <HistoryPage />
            </ProtectedRoute>
          } />
          <Route path="/volunteer/proof-upload" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <ProofUploadPage />
            </ProtectedRoute>
          } />
          <Route path="/volunteer/certificates" element={
            <ProtectedRoute allowedRoles={["TinhNguyenVien"]}>
              <MyCertificatesPage />
            </ProtectedRoute>
          } />

          {/* Default Route */}
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
