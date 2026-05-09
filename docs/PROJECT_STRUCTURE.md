# Cấu Trúc Dự Án

## Tổng Quan

Hệ thống Quản Lý Hoạt Động Tình Nguyện Sinh Viên — một ứng dụng **Desktop App** được xây dựng trên nền tảng **Tauri 2.x**, kết hợp:

- **Frontend (UI Layer):** React 18 + Vite
- **Backend (Native Layer):** Rust
- **Database:** Oracle 19c

---

## Tech Stack

| Thành phần | Công nghệ | Phiên bản | Mục đích |
|:---|:---|:---|:---|
| **Framework Desktop** | Tauri | 2.x | Đóng gói React + Rust thành native app |
| **Frontend** | React | 18.x | Giao diện người dùng (SPA) |
| **Build Tool** | Vite | 5.x | Dev server & bundler cho React |
| **Backend Native** | Rust | 1.75+ | Xử lý nghiệp vụ, kết nối DB |
| **Database** | Oracle | 19c (Non-CDB) | Lưu trữ dữ liệu, SP/SF/Trigger |
| **Oracle Client** | Oracle Instant Client | 19.x | OCI driver để Rust kết nối Oracle |
| **Package Manager** | npm | 10.x | Quản lý dependencies React |
| **Rust Package Manager** | Cargo | (theo Rust) | Quản lý dependencies Rust |

### Thư viện Rust chính (`Cargo.toml`)

| Crate | Mục đích |
|:---|:---|
| `tauri` | Framework desktop, IPC giữa React ↔ Rust |
| `oracle` | Kết nối Oracle DB qua OCI |
| `serde` / `serde_json` | Serialize/Deserialize struct ↔ JSON |
| `tokio` | Async runtime cho non-blocking DB calls |

### Thư viện React chính (`package.json`)

| Package | Mục đích |
|:---|:---|
| `@tauri-apps/api` | Gọi Rust commands từ JavaScript (`invoke()`) |
| `react-router-dom` | Routing giữa các trang |
| `react` / `react-dom` | Core UI framework |

---

## Kiến Trúc 3 Lớp

```
┌─────────────────────────────────────────────────────────┐
│                    TAURI DESKTOP APP                     │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │           UI LAYER (React + Vite)                 │  │
│  │  src/pages/         → Các trang chính             │  │
│  │  src/components/    → UI components tái sử dụng   │  │
│  │  src/services/      → invoke() wrapper functions  │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ invoke("ten_command", {args})  │
│                         │ (IPC qua Tauri)                │
│  ┌──────────────────────▼────────────────────────────┐  │
│  │        BUSINESS LOGIC LAYER (Rust Commands)       │  │
│  │  src-tauri/src/commands/  → #[tauri::command] fn  │  │
│  │  - Validate input                                 │  │
│  │  - Kiểm tra điều kiện nghiệp vụ                  │  │
│  │  - Gọi DAL và trả kết quả về React               │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ Gọi hàm trong db module       │
│  ┌──────────────────────▼────────────────────────────┐  │
│  │       DATA ACCESS LAYER (Rust → Oracle)           │  │
│  │  src-tauri/src/db/        → OCI connection pool   │  │
│  │  - Gọi Stored Procedures (CALL SP_XXX)            │  │
│  │  - Gọi Stored Functions (SELECT SF_XXX FROM DUAL) │  │
│  │  - Map kết quả → Rust Struct (DTO)                │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ SQL*Net / OCI                  │
└─────────────────────────┼───────────────────────────────┘
                          │
              ┌───────────▼───────────┐
              │   ORACLE DATABASE     │
              │   19c (Non-CDB)       │
              │                       │
              │   28 Tables           │
              │   32 Stored Procs     │
              │   6  Stored Funcs     │
              │   33 Triggers         │
              │   87 Indexes          │
              └───────────────────────┘
```

---

## Cấu Trúc Thư Mục

```
VolunteerManagementSystem/
├── database/                    # ===== LỚP DỮ LIỆU GỐC (Oracle) =====
│   ├── 00_DB_Script.sql         # File tổng hợp (concat 01→08), deploy nhanh
│   ├── 01_sequences.sql         # 24 Sequences cho auto-increment PK
│   ├── 02_tables.sql            # 28 Bảng với FK, CHECK, UNIQUE constraints
│   ├── 03_indexes.sql           # 87 Indexes tối ưu hiệu năng truy vấn
│   ├── 04_triggers_auto_pk.sql  # 24 Triggers tự động sinh PK
│   ├── 05_triggers_business.sql # 9 Triggers kiểm tra nghiệp vụ
│   ├── 06_stored_procedures.sql # 32 Stored Procedures
│   ├── 07_stored_functions.sql  # 6 Stored Functions
│   └── 08_SeedData.sql          # Dữ liệu mẫu: 966+ records / 21 bảng
│
├── docs/                        # ===== TÀI LIỆU DỰ ÁN =====
│   ├── Database_Progress.md     # Tracker tiến độ & Changelog database
│   ├── PROJECT_STRUCTURE.md     # Giải thích cấu trúc dự án (file này)
│   ├── GIT_GUIDELINE.md         # Quy trình Git Flow & branching
│   ├── GIT_COMMIT.md            # Quy tắc đặt tên commit
│   └── COMPLETE_Template.docx   # Template tài liệu đồ án
│
├── src/                         # ===== TẦNG GIAO DIỆN (React + Vite) =====
│   ├── components/              # Các thành phần UI tái sử dụng
│   ├── pages/                   # Các trang chính
│   │   ├── CampaignPage.jsx     # Gọi command Rust để lấy dữ liệu chiến dịch
│   │   └── AttendancePage.jsx   # Giao diện điểm danh
│   ├── services/                # Nơi chứa các hàm invoke() xuống Rust
│   │   └── tauriApi.js          # Wrapper functions cho Tauri IPC
│   ├── App.jsx                  # Root component, khai báo routes
│   ├── main.jsx                 # Entry point React (ReactDOM.createRoot)
│   └── index.css                # Global styles
│
├── src-tauri/                   # ===== TẦNG XỬ LÝ NATIVE (Rust) =====
│   ├── src/
│   │   ├── db/                  # Tầng Truy cập Dữ liệu (DAL)
│   │   │   ├── mod.rs           # Cấu hình kết nối Oracle (OCI connection pool)
│   │   │   └── procedures.rs    # Code gọi 32 Stored Procedures
│   │   ├── commands/            # Tầng Nghiệp vụ (BLL)
│   │   │   ├── mod.rs           # Khai báo & re-export các lệnh cho Frontend
│   │   │   └── campaign_cmd.rs  # Logic: Validate → Gọi SP → Trả JSON
│   │   ├── models/              # Các Struct ánh xạ Table (DTO)
│   │   │   └── mod.rs           # Khai báo struct Campaign, Student, ...
│   │   └── main.rs              # Khởi tạo Tauri app, đăng ký commands
│   ├── Cargo.toml               # Quản lý thư viện Rust (tauri, oracle, serde)
│   └── tauri.conf.json          # Cấu hình Tauri (window, app name, ...)
│
├── index.html                   # HTML entry point cho Vite
├── package.json                 # Quản lý React & Tauri scripts
├── README.md                    # Giới thiệu dự án
└── .gitignore                   # Ignore node_modules, target, dist
```

---

## Quy Tắc Làm Việc Với TechStack

### 1. Frontend — React (`src/`)

| Quy tắc | Mô tả |
|:---|:---|
| **Tổ chức file** | Mỗi trang = 1 file trong `pages/`, mỗi component tái sử dụng = 1 file trong `components/` |
| **Gọi Backend** | **KHÔNG** gọi trực tiếp Oracle từ React. Luôn đi qua `invoke()` → Rust command |
| **Service layer** | Mọi lệnh `invoke()` phải được wrap trong `src/services/tauriApi.js` để tập trung quản lý |
| **State management** | Dùng React hooks (`useState`, `useEffect`). Nâng cấp lên Context/Zustand khi cần |
| **Naming** | Components: `PascalCase.jsx`, services: `camelCase.js` |
| **Error handling** | Luôn `try/catch` khi gọi `invoke()`, hiển thị thông báo lỗi cho user |

**Ví dụ gọi Rust command từ React:**

```jsx
// src/services/tauriApi.js
import { invoke } from "@tauri-apps/api/core";

export async function getDanhSachChienDich() {
  return await invoke("get_danh_sach_chien_dich");
}

export async function dangKyChienDich(maSV, maCD) {
  return await invoke("dang_ky_chien_dich", { maSv: maSV, maCd: maCD });
}
```

```jsx
// src/pages/CampaignPage.jsx
import { useEffect, useState } from "react";
import { getDanhSachChienDich } from "../services/tauriApi";

function CampaignPage() {
  const [campaigns, setCampaigns] = useState([]);

  useEffect(() => {
    getDanhSachChienDich()
      .then(setCampaigns)
      .catch((err) => console.error("Lỗi:", err));
  }, []);

  return (/* render campaigns */);
}
```

### 2. Backend Native — Rust (`src-tauri/`)

| Quy tắc | Mô tả |
|:---|:---|
| **Command = BLL** | Mỗi `#[tauri::command]` fn trong `commands/` là 1 endpoint cho Frontend |
| **DB = DAL** | Code truy vấn Oracle chỉ nằm trong `db/`. Command KHÔNG viết SQL trực tiếp |
| **Models = DTO** | Struct trong `models/` phải derive `Serialize` để trả JSON về React |
| **Error handling** | Trả `Result<T, String>` cho mọi command. Frontend nhận lỗi qua `.catch()` |
| **Naming** | Commands: `snake_case`, Structs: `PascalCase`, modules: `snake_case` |
| **Connection** | Dùng connection pool (lazy_static / OnceCell), KHÔNG tạo connection mỗi lần gọi |

**Ví dụ Rust command:**

```rust
// src-tauri/src/commands/campaign_cmd.rs
use crate::db::procedures;
use crate::models::Campaign;

#[tauri::command]
pub fn get_danh_sach_chien_dich() -> Result<Vec<Campaign>, String> {
    procedures::call_sp_get_all_campaigns()
        .map_err(|e| format!("Lỗi truy vấn: {}", e))
}

#[tauri::command]
pub fn dang_ky_chien_dich(ma_sv: String, ma_cd: String) -> Result<String, String> {
    // 1. Validate input
    if ma_sv.is_empty() || ma_cd.is_empty() {
        return Err("Mã sinh viên và mã chiến dịch không được rỗng".into());
    }
    // 2. Gọi Stored Procedure
    procedures::call_sp_dangky_cd(&ma_sv, &ma_cd)
        .map(|_| "Đăng ký thành công".into())
        .map_err(|e| format!("Lỗi đăng ký: {}", e))
}
```

```rust
// src-tauri/src/main.rs
mod commands;
mod db;
mod models;

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            commands::campaign_cmd::get_danh_sach_chien_dich,
            commands::campaign_cmd::dang_ky_chien_dich,
        ])
        .run(tauri::generate_context!())
        .expect("Lỗi khởi tạo Tauri app");
}
```

### 3. Database — Oracle (`database/`)

| Quy tắc | Mô tả |
|:---|:---|
| **Logic tập trung** | Mọi logic nghiệp vụ phức tạp nằm trong **Stored Procedures/Functions** |
| **Rust chỉ gọi SP** | Backend Rust gọi `CALL SP_XXX(...)`, KHÔNG viết raw SQL nghiệp vụ |
| **Thứ tự deploy** | Luôn chạy scripts theo thứ tự 01 → 08 (xem phần bên dưới) |
| **Tham số hóa** | Dùng bảng `ThamSo` cho cấu hình động, KHÔNG hard-code giá trị |
| **Migration** | Mọi thay đổi schema phải cập nhật file `.sql` tương ứng + ghi Changelog |

### 4. Luồng Dữ Liệu End-to-End

```
User click "Đăng ký"
       │
       ▼
[React] CampaignPage.jsx
       │ gọi dangKyChienDich(maSV, maCD)
       ▼
[Service] tauriApi.js
       │ invoke("dang_ky_chien_dich", { maSv, maCd })
       ▼
[Rust Command] campaign_cmd.rs
       │ validate → gọi procedures::call_sp_dangky_cd()
       ▼
[Rust DAL] procedures.rs
       │ conn.execute("CALL SP_DANGKY_CD(:1, :2)", &[&ma_sv, &ma_cd])
       ▼
[Oracle] SP_DANGKY_CD
       │ INSERT INTO ThamGiaTNV + business triggers fire
       ▼
Result trả ngược về React → hiển thị "Đăng ký thành công"
```

---

## Thứ Tự Chạy Database Scripts

Các file SQL phải được chạy **theo đúng thứ tự** do dependency giữa các thành phần:

```
01_sequences.sql          Sequences (không phụ thuộc gì)
       ↓
02_tables.sql             Tables + FK constraints (phụ thuộc sequences qua triggers)
       ↓
03_indexes.sql            Indexes (phụ thuộc tables)
       ↓
04_triggers_auto_pk.sql   Auto PK Triggers (phụ thuộc tables + sequences)
       ↓
05_triggers_business.sql  Business Triggers (phụ thuộc tables)
       ↓
06_stored_procedures.sql  Stored Procedures (phụ thuộc tables)
       ↓
07_stored_functions.sql   Stored Functions (phụ thuộc tables)
       ↓
[Recompile nếu cần]      ALTER PROCEDURE SP_CAP_CHUNGNHAN_CD COMPILE;
       ↓
08_SeedData.sql           Seed Data (phụ thuộc tất cả ở trên)
```

> **Lưu ý:** `06_stored_procedures.sql` chứa `SP_CAP_CHUNGNHAN_CD` tham chiếu `SF_GET_XEP_LOAI` trong `07_stored_functions.sql`. Vì vậy sau khi chạy xong cả 2 file, cần recompile procedure này.

---

## Mô Hình Dữ Liệu

Hệ thống quản lý **20 chiến dịch tình nguyện** với 3 vai trò chính:

| Vai trò | Mô tả | Số lượng mẫu |
|:---|:---|:---|
| **BanQuanLy** | Quản trị hệ thống, duyệt chiến dịch | 2 |
| **BanDieuHanh** | Quản lý vận hành từng chiến dịch (1:1 với ChienDich) | 20 |
| **TinhNguyenVien** | Tham gia, điểm danh, nhận chứng nhận | 50 |

### Luồng Nghiệp Vụ Chính

```
TaiKhoan → HoSoSinhVien → ThamGiaTNV → PhanCong → DiemDanh → GiayChungNhan
                              ↑
                          ChienDich → CongViec
                              ↑
                        BanDieuHanh (Class Table Inheritance)
                              ↑
                      DuyetChienDich ← BanQuanLy
```

---

## Môi Trường Phát Triển

| Thành phần | Phiên bản | Ghi chú |
|:---|:---|:---|
| **Database** | Oracle 19c (Non-CDB) | SID: `orcl` |
| **DB User** | `hqtcsdldb` / `hqtcsdl123` | |
| **DB Client** | SQL*Plus 19.3 / SQL Developer | |
| **Rust** | 1.75+ (stable) | `rustup update stable` |
| **Node.js** | 20.x LTS | Cho React dev server |
| **npm** | 10.x | Đi kèm Node.js |
| **Tauri CLI** | 2.x | `cargo install tauri-cli` |
| **Oracle Instant Client** | 19.x | Bắt buộc cho crate `oracle` |
| **OS** | Windows 10/11 | |

### Cài Đặt Môi Trường Phát Triển

```bash
# 1. Cài Rust (nếu chưa có)
# Tải từ https://rustup.rs/

# 2. Cài Tauri CLI
cargo install tauri-cli

# 3. Cài Node dependencies
npm install

# 4. Chạy ứng dụng ở chế độ development
npm run tauri dev
```

---

## Scripts Thường Dùng

| Lệnh | Mô tả |
|:---|:---|
| `npm run dev` | Chạy React dev server (Vite) |
| `npm run tauri dev` | Chạy Tauri app ở chế độ development |
| `npm run tauri build` | Build production `.exe` |
| `npm run build` | Build React production bundle |
