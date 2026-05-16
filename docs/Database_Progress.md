# Database Progress Tracker

Tài liệu này theo dõi tiến độ hoàn thiện các thành phần của Database (Tables, Triggers, Stored Procedures, Stored Functions).

## 1. Tables (Bảng dữ liệu)

| Tên Bảng | Status | Ghi chú |
| :--- | :--- | :--- |
| TAIKHOAN | Complete | |
| HOSOSINHVIEN | Complete | |
| NHATKYHETHONG | Complete | |
| DOITAC | Complete | |
| LOAIVATPHAM | Complete | |
| THAMSO | Complete | Cấu hình tham số hệ thống |
| CHIENDICH | Affected | by thêm cột `GioToiThieuCN` |
| BANDIEUHANH | Complete | Class Table Inheritance cho role BanDieuHanh |
| DUYETCHIENDICH | Complete | |
| TINTUC | Complete | |
| BINHLUAN | Complete | |
| THAMGIATNV | Complete | |
| CONGVIEC | Complete | |
| PHANCONG | Complete | |
| DIEMDANH | Complete | |
| MINHCHUNGTNV | Complete | |
| GIAYCHUNGNHAN | Complete | |
| QUYENGOPTIEN | Complete | |
| THANHTOAN | Complete | |
| MINHCHUNGCHITIEU | Complete | |
| CHITIEU | Complete | |
| TAITRO | Complete | |
| PHIEUQUYENGOPVP | Complete | |
| CHITIETQUYENGOPVP | Complete | |
| PHIEUXUATVATPHAM | Complete | |
| CHITIETXUATVP | Complete | |
| THONGBAO | Complete | |
| THEODOI | Complete | |
| KHOCHIENDICH | Complete | [MIGRATION 14] Quản lý kho riêng cho từng chiến dịch |

## 2. Triggers (Business Logic)

| Tên Trigger | Status | Ghi chú |
| :--- | :--- | :--- |
| TRG_KIEMTRA_SOLUONG_DANGKY | Complete | |
| TRG_CAPNHAT_SOLUONG_TNV | Complete | |
| TRG_KIEMTRA_TRUNG_LICH | Complete | |
| TRG_TINHDIEM_THUONG | Complete | |
| TRG_CHANXOA_CHIENDICH | Complete | |
| TRG_KIEMTRA_TUOI_TNV | Complete | by áp dụng `TUOI_TOI_THIEU` từ `THAMSO` |
| TRG_HUY_CHIENDICH_DONGLOAT | Complete | |
| TRG_KIEMTRA_THOIGIAN | Complete | |
| TRG_GIOIHAN_NHIEMVU | Complete | by áp dụng `SO_NHIEM_VU_TOI_DA` từ `THAMSO` |

## 3. Stored Procedures (SPs)

| Tên SP | Status | Ghi chú |
| :--- | :--- | :--- |
| SP_DANGKYTAIKHOAN_TNV | Complete | |
| SP_CAPNHAT_HOSO_TNV | Complete | |
| SP_CAPNHAT_VAITRO | Complete | |
| SP_KIEMTRA_QUYEN | Complete | |
| SP_LOG_ACTION | Complete | |
| SP_THEM_CHIENDICH_MOI | Complete | |
| SP_CAPNHAT_CHIENDICH | Complete | |
| SP_XOA_CHIENDICH | Complete | |
| SP_MO_DANGKY_CD | Complete | |
| SP_DONG_CHIENDICH | Complete | |
| SP_THEM_CONGVIEC | Complete | |
| SP_PHANCONG_TNV | Complete | |
| SP_TNV_DANGKY_THAMGIA | Complete | |
| SP_DUYET_DANGKY_TNV | Complete | |
| SP_DIEMDANH_TNV | Complete | |
| SP_CAPNHAT_MINHCHUNG | Complete | |
| SP_DANHGIA_TNV | Complete | |
| SP_CAP_CHUNGNHAN_CD | Affected | by thêm logic `GioToiThieuCN` và `GIO_CONG_MAC_DINH` |
| SP_GHI_NHAN_QUYENGOP | Complete | |
| SP_THEM_PHIEU_CHI | Complete | |
| SP_THEM_DOITAC | Complete | |
| SP_NHAPKHO_VATPHAM | Affected | [MIGRATION 15] Cập nhật để hỗ trợ KHOCHIENDICH |
| SP_XUATKHO_VATPHAM | Affected | [MIGRATION 15] Cập nhật để hỗ trợ KHOCHIENDICH |
| SP_CAPNHAT_VATPHAM | Complete | |
| SP_LAY_DS_CHIENDICH_MO | Complete | |
| SP_LAY_TNV_THEO_CD | Complete | |
| SP_LAY_LICHSU_TNV | Complete | |
| SP_LAY_VP_TONKHO_THAP | Complete | by áp dụng `NGUONG_TON_KHO_CANH_BAO` từ `THAMSO` |
| SP_LAY_DS_TINTUC | Complete | |
| SP_THAYDOI_THAMSO | Complete | |
| SP_BAOCAO_HIEUQUA_CD | Complete | |
| SP_XOA_TAI_KHOAN | Complete | [MIGRATION 12] Xóa tài khoản an toàn |

## 4. Stored Functions (SFs)

| Tên SF | Status | Ghi chú |
| :--- | :--- | :--- |
| SF_TINH_TONG_GIO_TNV | Complete | |
| SF_TINH_NGAN_QUY_CD | Complete | |
| SF_CHECK_DK_THAMGIA | Complete | |
| SF_THONGKE_TNV_KHOA | Complete | |
| SF_GET_XEP_LOAI | Complete | by áp dụng các ngưỡng Xếp loại từ `THAMSO` |
| SF_KIEMTRA_TONKHO_VP | Complete | |

---

## 5. Logic Mapping (Mối quan hệ dữ liệu)

Mục này liệt kê các yếu tố ràng buộc logic giữa các thành phần trong database nhằm mục đích đảm bảo tính toàn vẹn và hợp logic khi tạo Seed Data:

* **Tham Số Hệ Thống (THAMSO)**:
  * `DIEM_XUAT_SAC`, `GIO_XUAT_SAC`, `DIEM_TOT`, `GIO_TOT`, `DIEM_KHA`, `GIO_KHA` -> Quyết định kết quả của `SF_GET_XEP_LOAI` và gián tiếp đến `SP_CAP_CHUNGNHAN_CD`. (Seed data điểm danh cần khớp ngưỡng này để test).
  * `GIO_CONG_MAC_DINH` -> Quyết định điều kiện cấp chứng nhận `SP_CAP_CHUNGNHAN_CD` nếu Chiến dịch không có `GioToiThieuCN`.
  * `TUOI_TOI_THIEU` -> Bị kiểm tra bởi `TRG_KIEMTRA_TUOI_TNV` khi insert/update `HoSoSinhVien` (Tuổi TNV trong seed data phải >= mức này).
  * `SO_NHIEM_VU_TOI_DA` -> Bị kiểm tra bởi `TRG_GIOIHAN_NHIEMVU` khi phân công (TNV không được nhận nhiều hơn số lượng này).
  * `NGUONG_TON_KHO_CANH_BAO` -> Ảnh hưởng kết quả của `SP_LAY_VP_TONKHO_THAP`.

* **Trạng thái & Số lượng Chiến dịch (CHIENDICH)**:
  * `SoLuongTNVToiDa` & `SoLuongHienTai` -> Bị kiểm tra bởi `TRG_KIEMTRA_SOLUONG_DANGKY` và `SF_CHECK_DK_THAMGIA`. `SoLuongHienTai` sẽ tự động tăng/giảm thông qua `TRG_CAPNHAT_SOLUONG_TNV`.
  * `NgayBatDau` & `NgayKetThuc` -> Ảnh hưởng đến lịch của TNV, bị chặn bởi `TRG_KIEMTRA_TRUNG_LICH` nếu trùng.
  * Khi `TrangThai` = 'Huy' -> `TRG_HUY_CHIENDICH_DONGLOAT` sẽ hủy toàn bộ các đăng ký của `ThamGiaTNV` liên quan.
  * Nếu `TrangThai` = 'DangHoatDong' -> Sẽ không thể xóa chiến dịch (`TRG_CHANXOA_CHIENDICH`).

* **Hoạt động tình nguyện (THAMGIATNV & CONGVIEC)**:
  * [CẬP NHẬT] Tổng giờ của TNV được tính tự động từ khoảng thời gian giữa `ThoiGianBatDau` và `ThoiGianKetThuc` của tất cả `CONGVIEC` được phân công.
  * Khi duyệt `ThamGiaTNV.TrangThaiDuyet` sang 'HoanThanh' -> `TRG_TINHDIEM_THUONG` sẽ tự động cộng `ChienDich.DiemThuong` vào `HoSoSinhVien.TongDiem`.

* **Quản lý Kho (KHOCHIENDICH)**:
  * Vật phẩm được nhập/xuất theo từng chiến dịch cụ thể. `SP_NHAPKHO_VATPHAM` sẽ kiểm tra sự tồn tại của vật phẩm trong kho chiến dịch trước khi cập nhật.

---

## Changelog (Nâng cấp hệ thống)

* **[2026-05-16] Cải tiến Logic Hoạt động & Báo cáo:**
  * **Migration 11:** Triển khai cơ chế tính giờ tự động theo thời gian thực thi công việc (Task-based duration). Loại bỏ việc nhập giờ thủ công.
  * **Migration 14 & 15:** Thiết lập hệ thống Kho vật phẩm riêng biệt cho từng Chiến dịch (`KHOCHIENDICH`) và cập nhật các thủ tục nhập/xuất kho tương ứng.
  * **Báo cáo Tài chính:** Nâng cấp Stored Procedure báo cáo để hỗ trợ dữ liệu theo tuần cho biểu đồ trên Frontend.
  * **Cleanup:** Dọn dẹp toàn bộ các script rác ở Backend và thư mục `src` rỗng ở Frontend.

* **[2026-05-09] Fix Critical Bugs & Deploy Database to Oracle:**
  * **Fix `06_stored_procedures.sql`:**
    * Sửa lỗi hard-code `MaTaiKhoan = 1` (NUMBER) trong `SP_NHAPKHO_VATPHAM` → thay bằng subquery `(SELECT MIN(MaTaiKhoan) FROM TaiKhoan WHERE VaiTro = 'BanQuanLy')` để tự động lấy ID admin hợp lệ (VARCHAR2).
    * Xoá procedure `SP_XOA_CHIENDICH` bị khai báo trùng lặp ở cuối file.
  * **Fix `08_SeedData.sql`:**
    * Thêm `SET DEFINE OFF` để ngăn SQL*Plus hiểu nhầm ký tự `&` trong dữ liệu là substitution variable.
    * Thêm 10 dòng INSERT cho bảng `ThamSo` (dữ liệu bắt buộc cho 3 triggers + 2 functions phụ thuộc). Thiếu data này sẽ gây `NO_DATA_FOUND` chặn toàn bộ seed data.
    * Xoá cột `GioQuyDinh` khỏi 40 câu INSERT vào bảng `CongViec` (cột không tồn tại trong schema `02_tables.sql`).
    * Thêm `EXECUTE IMMEDIATE 'ALTER TRIGGER ... DISABLE/ENABLE'` cho 3 triggers (`TRG_KIEMTRA_THOIGIAN`, `TRG_KIEMTRA_TRUNG_LICH`, `TRG_KIEMTRA_SOLUONG_DANGKY`) để cho phép insert dữ liệu mẫu có ngày quá khứ và TNV tham gia nhiều chiến dịch trùng lịch.
  * **Tái tạo `00_DB_Script.sql`** từ tất cả file thành phần (01→08).
  * **Triển khai thành công trên Oracle 19c (Non-CDB):** User `hqtcsdldb`@`orcl`, 0 INVALID objects, 966+ bản ghi trên 21 bảng.

* **[2026-05-06] Refactor User/Role to Class Table Inheritance:**
  * Tạo bảng `BANDIEUHANH` để chứa các thuộc tính riêng (`MaChienDich`, `NgayPhanCong`) của role `BanDieuHanh`, giúp enforce ràng buộc 1-1 giữa Chiến dịch và Ban Điều Hành bằng `UNIQUE(MaChienDich)`.
  * Cập nhật procedure `SP_CAPNHAT_VAITRO` để tự động xử lý insert/delete vào `BANDIEUHANH` khi role thay đổi.
  * Thêm các procedure mới: `SP_THIET_LAP_BDH` và `SP_XOA_CHIENDICH` vào `06_stored_procedures.sql`.
  * Sửa đổi script sinh Seed Data (`generate_seed.py`) để populate bảng `BANDIEUHANH`.

* **[2026-05-06] Generate Seed Data (20 Campaigns 2024-2025):**
  * Xóa các file `08_thamso_init.sql` và `09_test_thamso.sql`.
  * Tạo script `08_SeedData.sql` chứa khối PL/SQL khổng lồ để tự động Insert dữ liệu cho toàn bộ 27 bảng.
  * Dữ liệu mô phỏng 20 chiến dịch tình nguyện thực tế của ĐHQG-HCM (Xuân Tình Nguyện, Mùa Hè Xanh, Tiếp Sức Mùa Thi, v.v.).
  * Logic giả lập quá trình đăng ký, phân công, điểm danh, cấp chứng nhận, tài trợ, nhập/xuất kho tự động kích hoạt các Trigger và Stored Procedures.
  * Cập nhật khối `DROP TABLE` trong `02_tables.sql` thành PascalCase với `UPPER()` để an toàn và đẹp hơn, đồng thời sửa lỗi gõ sai chữ `NhatKyHeThong`.

* **[2026-05-06] Refactor ID attributes to VARCHAR2(10):**
  * Đổi kiểu dữ liệu của tất cả các cột Khóa chính và Khóa ngoại (`Ma...`) trong `02_tables.sql` từ `NUMBER` sang `VARCHAR2(10)`.
  * Cập nhật `04_triggers_auto_pk.sql` để tự động nối Prefix 2 chữ cái (ví dụ `TK`, `CD`) với giá trị của Sequence (được LPAD 8 số) để tạo ID dạng chuỗi (VD: `TK00000001`).
  * Sửa lại toàn bộ Stored Procedures (`06_stored_procedures.sql`), Functions (`07_stored_functions.sql`), và Triggers (`05_triggers_business.sql`) để nhận các tham số và biến cục bộ dạng `VARCHAR2` thay vì `NUMBER`.
  * Cập nhật `08_thamso_init.sql` để insert ID theo format `TS00000001`.

* **[2026-05-06] Refactor Database Parameter:**
  * Thêm cột `GioToiThieuCN` vào bảng `CHIENDICH`.
  * Thêm tham số mặc định `GIO_CONG_MAC_DINH` vào bảng `THAMSO`.
  * Refactor `SP_CAP_CHUNGNHAN_CD` để kiểm tra điều kiện giờ tối thiểu lấy từ `CHIENDICH` trước, sau đó fallback về `THAMSO`.
  * Xác nhận các hàm/trigger như `SF_GET_XEP_LOAI`, `TRG_KIEMTRA_TUOI_TNV`, `TRG_GIOIHAN_NHIEMVU`, `SP_LAY_VP_TONKHO_THAP` đã áp dụng cấu hình động.
  * Tạo script test `09_test_thamso.sql`.
