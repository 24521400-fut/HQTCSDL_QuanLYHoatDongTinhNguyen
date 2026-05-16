# Cấu Trúc Dự Án

## Tổng Quan

Hệ thống Quản Lý Hoạt Động Tình Nguyện Sinh Viên — một ứng dụng **Desktop App** được xây dựng trên nền tảng **Electron**, kết hợp:

- **Frontend (UI Layer):** React 18 + Vite
- **Backend (Server Layer):** Node.js + Express
- **Database:** Oracle 19c

---

## Tech Stack

| Thành phần | Công nghệ | Phiên bản | Mục đích |
|:---|:---|:---|:---|
| **Framework Desktop** | Electron | 30.x+ | Đóng gói React + Node.js thành native app |
| **Frontend** | React | 18.x | Giao diện người dùng (SPA) |
| **Build Tool** | Vite | 5.x | Dev server & bundler cho React |
| **Backend** | Node.js (Express) | 20.x+ | Xử lý nghiệp vụ, API RESTful |
| **Database** | Oracle | 19c (Non-CDB) | Lưu trữ dữ liệu, SP/SF/Trigger |
| **Oracle Client** | Thin Mode | N/A | Driver Node.js (`oracledb`) kết nối Oracle không cần Instant Client |
| **Package Manager** | npm | 10.x | Quản lý dependencies |
| **Charts** | Chart.js | 4.x | Thư viện vẽ biểu đồ thống kê |

### Thư viện Backend chính (`backend/package.json`)

| Package | Mục đích |
|:---|:---|
| `express` | Framework xây dựng REST API |
| `oracledb` | Kết nối Oracle DB (chế độ Thin Mode) |
| `bcryptjs` | Hash và kiểm tra mật khẩu |
| `cors` | Quản lý CORS policies |
| `dotenv` | Quản lý biến môi trường |

### Thư viện Frontend chính (`package.json`)

| Package | Mục đích |
|:---|:---|
| `react-router-dom` | Routing giữa các trang |
| `react` / `react-dom` | Core UI framework |
| `chart.js` / `react-chartjs-2` | Hiển thị biểu đồ báo cáo tài chính |
| `axios` / `fetch` | Giao tiếp với Backend API |

---

## Kiến Trúc 3 Lớp

```
┌─────────────────────────────────────────────────────────┐
│                 ELECTRON DESKTOP APP                    │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │           UI LAYER (React + Vite)                 │  │
│  │  frontend/pages/      → Các trang chính           │  │
│  │  frontend/components/ → UI components tái sử dụng │  │
│  │  frontend/services/   → Gọi REST API (Axios/Fetch)│  │
│  │  frontend/context/    → Quản lý Auth/State        │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ HTTP GET/POST/PUT/DELETE      │
│                         │ (localhost:3000/api/...)      │
│  ┌──────────────────────▼────────────────────────────┐  │
│  │        BUSINESS LOGIC LAYER (Node.js/Express)     │  │
│  │  backend/src/controllers/ → Định nghĩa API Routes │  │
│  │  backend/src/services/    → Logic & Truy vấn SQL  │  │
│  │  backend/src/db.js        → Oracle Connection     │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ oracledb Thin Mode            │
│  ┌──────────────────────▼────────────────────────────┐  │
│  │       DATA ACCESS LAYER (Oracle DB)               │  │
│  │  - Database Migration (Files 09-15)               │  │
│  │  - Gọi Stored Procedures (CALL SP_XXX)            │  │
│  │  - Gọi Stored Functions (SELECT SF_XXX FROM DUAL) │  │
│  └──────────────────────┬────────────────────────────┘  │
│                         │ TCP/IP                        │
└─────────────────────────┼───────────────────────────────┘
                          │
              ┌───────────▼───────────┐
              │   ORACLE DATABASE     │
              │   19c (Non-CDB)       │
              │                       │
              │   29 Tables (+1)      │
              │   34 Stored Procs (+2)│
              │   6  Stored Funcs     │
              │   35 Triggers (+2)    │
              │   92 Indexes (+5)     │
              └───────────────────────┘
```

---

## Cấu Trúc Thư Mục

```
VolunteerManagementSystem/
├── database/                        # ===== LỚP DỮ LIỆU GỐC (Oracle) =====
│   ├── 01→08_Core.sql               # Bộ khung CSDL cơ bản
│   ├── 09→15_Migrations.sql         # Các bản nâng cấp & Sửa lỗi nghiệp vụ
│   └── 08_SeedData.sql              # Dữ liệu mẫu thực tế
│
├── docs/                            # ===== TÀI LIỆU DỰ ÁN =====
│   ├── changelog/                   # Changelog phát triển các module
│   ├── Database_Progress.md         # Tracker tiến độ & Changelog database
│   ├── PROJECT_STRUCTURE.md         # Giải thích cấu trúc dự án (FILE NÀY)
│   └── ...                          # Các tài liệu nghiệp vụ khác
│
├── frontend/                        # ===== TẦNG GIAO DIỆN (React + Vite) =====
│   ├── assets/                      # Hình ảnh, logo hệ thống
│   ├── components/                  # UI components (Atom/Molecule/Organism)
│   ├── context/                     # Quản lý trạng thái (Auth, Campaign)
│   ├── styles/                      # Thiết kế giao diện (CSS Variables)
│   ├── pages/                       # Giao diện chính (Admin/BDH/TNV)
│   ├── services/                    # Tầng giao tiếp API
│   ├── App.jsx                      # Root Component & Routes
│   └── main.jsx                     # Entry point
│
├── backend/                         # ===== TẦNG XỬ LÝ (Node.js/Express) =====
│   ├── src/
│   │   ├── controllers/             # Định nghĩa Endpoint & Điều hướng
│   │   ├── services/                # Logic nghiệp vụ & Truy vấn SQL
│   │   ├── db.js                    # Kết nối Oracle (Thin Mode)
│   │   └── index.js                 # Khởi chạy Express Server
│   └── package.json                 # Cấu hình Backend
│
├── main.js                          # Cấu hình Electron (Native Window)
├── package.json                     # Scripts khởi chạy toàn hệ thống
├── vite.config.js                   # Cấu hình Vite
└── README.md                        # Hướng dẫn cài đặt chuẩn
```

---

## Môi Trường Phát Triển

| Thành phần | Phiên bản | Ghi chú |
|:---|:---|:---|
| **Database** | Oracle 19c (Non-CDB) | SID: `orcl` |
| **Node.js** | 20.x LTS | Cho Backend và React dev server |
| **OS** | Windows 10/11 | |

### Cài Đặt Môi Trường Phát Triển

```bash
# 1. Cài Frontend dependencies
npm install

# 2. Cài Backend dependencies
cd backend
npm install
cd ..

# 3. Chạy ứng dụng đồng thời cả Frontend, Backend và Electron
npm run dev:desktop
```

## Luồng Dữ Liệu End-to-End

```
User click "Đăng nhập"
       │
       ▼
[React] LoginPage.jsx
       │ gọi axios.post('/api/auth/login', payload)
       ▼
[Express Controller] authController.js
       │ gọi authService.loginUser(username, password)
       ▼
[Express Service] authService.js
       │ conn.execute("SELECT ... FROM TaiKhoan WHERE TenDangNhap = :1")
       ▼
[Oracle] Database
       │ Trả kết quả query
       ▼
Result trả ngược về Controller → React → Điều hướng user
```
