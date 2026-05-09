/**
 * tauriApi.js — Tầng Service: wrapper cho tất cả Tauri invoke() calls
 *
 * QUY TẮC QUAN TRỌNG:
 * 1. Mọi lệnh invoke() gọi xuống Rust đều PHẢI đi qua file này
 * 2. KHÔNG import invoke() trực tiếp trong components/pages
 * 3. Mỗi hàm tương ứng với 1 #[tauri::command] bên Rust
 * 4. Tên hàm JS dùng camelCase, tên command Rust dùng snake_case
 *
 * Cách thêm command mới:
 * 1. Tạo #[tauri::command] fn trong src-tauri/src/commands/
 * 2. Đăng ký command trong src-tauri/src/main.rs
 * 3. Thêm wrapper function tại đây
 */
import { invoke } from "@tauri-apps/api/core";

// ============================================================
//  CHIẾN DỊCH (Campaign)
// ============================================================

/** Lấy danh sách tất cả chiến dịch */
export async function getDanhSachChienDich() {
  return await invoke("get_danh_sach_chien_dich");
}

/** Lấy chi tiết 1 chiến dịch theo mã */
export async function getChiTietChienDich(maCD) {
  return await invoke("get_chi_tiet_chien_dich", { maCd: maCD });
}

/** Đăng ký tham gia chiến dịch */
export async function dangKyChienDich(maSV, maCD) {
  return await invoke("dang_ky_chien_dich", { maSv: maSV, maCd: maCD });
}

// ============================================================
//  ĐIỂM DANH (Attendance)
// ============================================================

/** Lấy danh sách điểm danh theo chiến dịch */
export async function getDanhSachDiemDanh(maCD) {
  return await invoke("get_danh_sach_diem_danh", { maCd: maCD });
}

/** Thực hiện điểm danh cho tình nguyện viên */
export async function diemDanh(maSV, maCD, ngay) {
  return await invoke("diem_danh", { maSv: maSV, maCd: maCD, ngay });
}

// ============================================================
//  SINH VIÊN (Student) — TODO: Thêm khi cần
// ============================================================

// export async function getDanhSachSinhVien() {
//   return await invoke("get_danh_sach_sinh_vien");
// }
