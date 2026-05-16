# 🎓 Hệ Thống Quản Lý Hoạt Động Tình Nguyện Sinh Viên

> Đồ án môn Hệ Quản Trị Cơ Sở Dữ Liệu — Oracle Database 19c

## Giới Thiệu

Hệ thống quản lý toàn diện các hoạt động tình nguyện của sinh viên ĐHQG-HCM, bao gồm: quản lý chiến dịch, đăng ký tình nguyện viên, phân công nhiệm vụ, điểm danh, cấp chứng nhận, quản lý vật phẩm và tài trợ.

Ứng dụng được xây dựng dưới dạng **Desktop App** chạy trên hệ điều hành Windows, sử dụng kiến trúc **Electron + React (Frontend) + Node.js/Express (Backend) + Oracle Database 19c (Database)**.

## Tính Năng Database

- **28 bảng** với ràng buộc toàn vẹn đầy đủ (FK, CHECK, UNIQUE)
- **33 triggers** (24 auto-PK + 9 business logic)
- **32 stored procedures** + **6 stored functions**
- **87 indexes** tối ưu hiệu năng
- **966+ bản ghi** dữ liệu mẫu mô phỏng 20 chiến dịch thực tế
- Bảng **ThamSo** cho cấu hình động (tuổi tối thiểu, số nhiệm vụ tối đa, ngưỡng xếp loại...)
- Mô hình **Class Table Inheritance** cho vai trò Ban Điều Hành

## Tính Năng Ứng Dụng

| Cụm | Tính năng chính | Vai trò |
|:---|:---|:---|
| **Cụm 1** | Đăng ký, đăng nhập, phân quyền RBAC, quản lý hồ sơ | Tất cả |
| **Cụm 2** | Tạo chiến dịch, đăng ký tham gia, duyệt & phân công nhiệm vụ | BQL, BDH, TNV |
| **Cụm 3** | Quản lý hậu cần kho, tài chính ngân quỹ, nộp/đối soát minh chứng | BQL, BDH, TNV |
| **Cụm 4** | Đánh giá & xếp loại, cấp chứng nhận hàng loạt, thống kê báo cáo | BQL, BDH, TNV |

---

## 📋 Hướng Dẫn Cài Đặt Đầy Đủ (Từ Máy Mới)

Hướng dẫn dưới đây giả định bạn đang sử dụng một **máy tính Windows mới** (ví dụ: Asus Zenbook 14 OLED) chưa cài đặt bất kỳ phần mềm lập trình nào. Sau khi hoàn thành tất cả các bước, bạn sẽ chạy được ứng dụng bằng lệnh `npm run dev:desktop`.

> **Lưu ý quan trọng:** Nếu máy bạn đã cài sẵn một phần mềm nào rồi (ví dụ đã có Node.js, Git, v.v.), bạn hoàn toàn có thể **bỏ qua bước cài đặt phần mềm đó** và chuyển sang bước tiếp theo. Không có bước nào gây lỗi nếu phần mềm đã tồn tại trên máy.

---

### Bước 1: Cài đặt Git

Git là công cụ quản lý mã nguồn, cần thiết để tải (clone) dự án từ GitHub về máy.

1. Mở trình duyệt web (Microsoft Edge có sẵn trên máy), truy cập: **https://git-scm.com/download/win**
2. Trang web sẽ tự động phát hiện hệ điều hành Windows và hiện nút tải xuống. Nhấn **"Click here to download"** để tải bản cài đặt mới nhất (64-bit).
3. Chạy file `.exe` vừa tải về.
4. Trong trình cài đặt, **nhấn "Next" liên tục** và giữ nguyên tất cả tùy chọn mặc định. Cuối cùng nhấn **"Install"**, chờ cài xong rồi nhấn **"Finish"**.
5. **Kiểm tra:** Mở ứng dụng **Windows Terminal** (hoặc **PowerShell**) bằng cách nhấn phím `Windows`, gõ `Terminal`, nhấn Enter. Sau đó gõ lệnh:
   ```
   git --version
   ```
   Nếu thấy hiện ra dòng chữ dạng `git version 2.x.x.windows.x` thì đã cài thành công. Nếu không thấy, hãy **khởi động lại máy tính** rồi thử lại.

---

### Bước 2: Cài đặt Node.js (bao gồm npm)

Node.js là nền tảng chạy JavaScript phía máy chủ (backend). Khi cài Node.js, công cụ quản lý package `npm` sẽ được cài kèm tự động.

1. Truy cập: **https://nodejs.org/en/download**
2. Chọn bản **LTS** (Long Term Support — bản ổn định). Tải file cài đặt `.msi` dành cho Windows (64-bit).
3. Chạy file `.msi` vừa tải.
4. Trong trình cài đặt:
   - Nhấn **"Next"** liên tục, đồng ý điều khoản (tick "I accept...").
   - **Giữ nguyên đường dẫn cài đặt mặc định** (`C:\Program Files\nodejs\`).
   - Khi gặp màn hình **"Tools for Native Modules"**: **KHÔNG cần tick** ô "Automatically install the necessary tools..." (dự án này không cần C++ build tools).
   - Nhấn **"Install"**, chờ cài xong, nhấn **"Finish"**.
5. **Kiểm tra:** Mở **Terminal** mới (đóng Terminal cũ nếu đang mở, mở lại để cập nhật biến môi trường), gõ lần lượt:
   ```
   node -v
   ```
   Kết quả mong đợi: `v20.x.x` hoặc `v22.x.x` (phiên bản LTS mới nhất).
   ```
   npm -v
   ```
   Kết quả mong đợi: `10.x.x` hoặc `11.x.x`.

---

### Bước 3: Cài đặt Oracle Database 19c

Oracle Database là hệ quản trị cơ sở dữ liệu mà toàn bộ dữ liệu của dự án nằm trên đó. Đây là bước **phức tạp nhất** và mất nhiều thời gian nhất (khoảng 30–60 phút).

#### 3.1. Tải Oracle Database 19c

1. Truy cập: **https://www.oracle.com/database/technologies/oracle-database-software-downloads.html**
2. Kéo xuống mục **"Oracle Database 19c"**, chọn tab **"Microsoft Windows x64 (64-bit)"**.
3. Nhấn **"ZIP"** để tải file `WINDOWS.X64_193000_db_home.zip` (khoảng 2.9 GB).
4. Bạn cần có tài khoản Oracle (miễn phí) để tải. Nếu chưa có, nhấn **"Create Account"** rồi đăng ký, sau đó quay lại tải.

#### 3.2. Giải nén và cài đặt

1. Tạo thư mục: `C:\oracle\db_home` (nhấn chuột phải trong ổ C → New → Folder).
2. Giải nén **toàn bộ nội dung** file ZIP vào thư mục `C:\oracle\db_home`. **Lưu ý quan trọng:** Giải nén trực tiếp vào thư mục này, không tạo thêm thư mục con bên trong.
3. Mở thư mục `C:\oracle\db_home`, tìm file **`setup.exe`**, nhấn chuột phải → **"Run as administrator"** (Chạy với quyền Quản trị viên).
4. Trình cài đặt Oracle Database (Oracle Universal Installer) sẽ mở ra. Thực hiện lần lượt:

   - **Configuration Option:** Chọn **"Create and configure a single instance database"** → Next.
   - **System Class:** Chọn **"Desktop class"** → Next.
   - **Oracle Home User:** Chọn **"Use Virtual Account"** → Next.
   - **Typical Installation:**
     - **Oracle base:** Giữ mặc định (ví dụ `C:\oracle`).
     - **Software location:** `C:\oracle\db_home` (đã tự điền).
     - **Database file location:** Giữ mặc định.
     - **Database edition:** **Enterprise Edition**.
     - **Character set:** **Unicode (AL32UTF8)**.
     - **Global database name:** Nhập `orcl`.
     - **Password:** Nhập mật khẩu cho tài khoản SYS và SYSTEM. Ghi nhớ mật khẩu này! Ví dụ: `OracleAdmin123`.
     - **Pluggable database name:** Xóa trắng hoặc bỏ tick **"Create as Container database"** nếu có tùy chọn này (dự án dùng **Non-CDB**).
   - Nhấn **Next** → **Install**. Quá trình cài đặt và tạo database sẽ mất khoảng 15–30 phút.
   - Khi hoàn tất, nhấn **"Close"**.

5. **Kiểm tra Oracle đã chạy:**
   - Mở **Terminal**, gõ:
     ```
     lsnrctl status
     ```
   - Nếu thấy dòng chứa `Service "orcl"` và `status READY`, Oracle Listener đã hoạt động.
   - Nếu Listener chưa chạy, gõ:
     ```
     lsnrctl start
     ```

#### 3.3. Tạo user cho dự án và nạp dữ liệu

1. Mở **Terminal**, gõ lệnh sau để kết nối vào Oracle với quyền SYSDBA:
   ```
   sqlplus sys/OracleAdmin123@localhost:1521/orcl as sysdba
   ```
   Thay `OracleAdmin123` bằng mật khẩu SYS bạn đã đặt ở bước 3.2. Nếu kết nối thành công, bạn sẽ thấy dòng `Connected to: Oracle Database 19c...`.

2. Tạo user `hqtcsdldb` cho dự án bằng các lệnh SQL sau (sao chép từng lệnh, dán vào SQL*Plus, nhấn Enter):
   ```sql
   CREATE USER hqtcsdldb IDENTIFIED BY hqtcsdl123
       DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
   ```
   ```sql
   GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE,
       CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE,
       CREATE TRIGGER, ALTER ANY TRIGGER TO hqtcsdldb;
   ```

3. Thoát khỏi session SYSDBA:
   ```sql
---

### Bước 4: Cài đặt thư viện (Dependencies) 📦

Mở CMD/Terminal tại thư mục gốc của dự án và chạy lệnh:
```bash
npm install
```
*Lưu ý: Bước này sẽ tự động cài đặt tất cả các thư viện cần thiết cho cả Frontend và Backend.*

---

### Bước 5: Nạp Cơ sở dữ liệu (Oracle Database) 🗄️

Đảm bảo bạn đang ở trong thư mục dự án. Mở CMD và gõ:
```sql
sqlplus sys as sysdba
```
(Sau đó nhập mật khẩu hệ thống của bạn).

Khi đã vào SQL*Plus, hãy chạy lần lượt các lệnh sau (Đảm bảo đường dẫn đúng đến thư mục `database` của dự án):

1. Tạo User và cấp quyền (Nếu chưa có):
   ```sql
   CREATE USER hqtcsdldb IDENTIFIED BY hqtcsdl123;
   GRANT CONNECT, RESOURCE, DBA TO hqtcsdldb;
   CONNECT hqtcsdldb/hqtcsdl123;
   ```

2. Nạp các thành phần theo thứ tự (Sử dụng đường dẫn tương đối):
   ```sql
   @./database/01_sequences.sql
   @./database/02_tables.sql
   @./database/03_indexes.sql
   @./database/04_triggers_auto_pk.sql
   @./database/05_triggers_business.sql
   @./database/06_stored_procedures.sql
   @./database/07_stored_functions.sql
   @./database/08_SeedData.sql
   ```

3. Biên dịch lại thủ tục (Nếu cần):
   ```sql
   ALTER PROCEDURE SP_CAP_CHUNGNHAN_CD COMPILE;
   ```

6. Kiểm tra kết quả nạp dữ liệu:
   ```sql
   SELECT object_name, object_type, status FROM user_objects WHERE status = 'INVALID';
   ```

7. Thoát SQL*Plus:
   ```sql
   EXIT;
   ```

> **Ghi chú:** Nếu bạn chưa clone dự án (chưa làm Bước 5), hãy làm Bước 4 và Bước 5 trước, rồi quay lại đây để nạp database.

---

### Bước 4: Cài đặt SQL*Plus vào biến môi trường PATH (nếu chưa có)

Thường khi cài Oracle Database, SQL*Plus đã tự động được thêm vào PATH. Nếu ở Bước 3.3 bạn gõ `sqlplus` mà Terminal báo **"command not found"**, hãy làm bước này:

1. Nhấn phím `Windows`, gõ **"Environment Variables"**, chọn **"Edit the system environment variables"**.
2. Nhấn nút **"Environment Variables..."** ở góc dưới.
3. Trong mục **"System variables"**, tìm biến **Path**, nhấn đúp vào.
4. Nhấn **"New"**, thêm đường dẫn: `C:\oracle\db_home\bin` (đường dẫn đến thư mục bin của Oracle).
5. Nhấn **"OK"** 3 lần để đóng tất cả cửa sổ.
6. **Đóng Terminal cũ**, mở Terminal mới, gõ lại `sqlplus -v` để kiểm tra.

---

### Bước 5: Clone dự án từ GitHub

1. Mở **Terminal**.
2. Di chuyển đến thư mục bạn muốn lưu dự án. Ví dụ, tạo thư mục `C:\Projects` và di chuyển vào:
   ```
   mkdir C:\Projects
   cd C:\Projects
   ```
   Nếu thư mục `C:\Projects` đã tồn tại, chỉ cần chạy `cd C:\Projects`.
3. Clone dự án:
   ```
   git clone https://github.com/24521400-fut/HQTCSDL_QuanLYHoatDongTinhNguyen.git
   ```
4. Chờ quá trình tải hoàn tất. Sau đó di chuyển vào thư mục dự án:
   ```
   cd HQTCSDL_QuanLYHoatDongTinhNguyen
   ```

---

### Bước 6: Cài đặt các thư viện phụ thuộc (Dependencies)

Dự án gồm 2 phần cần cài đặt riêng: **Frontend** (thư mục gốc) và **Backend** (thư mục `backend/`).

1. **Cài đặt dependencies cho Frontend + Electron** (đứng tại thư mục gốc dự án):
   ```
   npm install
   ```
   Lệnh này sẽ tải và cài đặt React, Vite, Electron, Recharts, và các thư viện khác. Quá trình có thể mất 2–5 phút tùy tốc độ mạng.

2. **Cài đặt dependencies cho Backend** (di chuyển vào thư mục backend):
   ```
   cd backend
   npm install
   ```
   Lệnh này sẽ cài đặt Express, oracledb (thin mode), bcryptjs, cors, và dotenv.

3. **Quay lại thư mục gốc** của dự án:
   ```
   cd ..
   ```

4. **Kiểm tra:** Đảm bảo bạn đang ở thư mục gốc dự án (thư mục chứa file `package.json`, `main.js`, `index.html`). Gõ:
   ```
   dir package.json
   ```
   Nếu thấy file `package.json` được liệt kê, bạn đang ở đúng vị trí.

---

### Bước 7: Đảm bảo Oracle Database đang chạy

Trước khi khởi chạy ứng dụng, Oracle Database phải đang hoạt động.

1. Nhấn phím `Windows`, gõ **"Services"** (Dịch vụ), mở ứng dụng **Services**.
2. Cuộn xuống tìm các dịch vụ có tên bắt đầu bằng **"Oracle"**:
   - **`OracleServiceORCL`** — Phải ở trạng thái **"Running"**. Nếu đang "Stopped", nhấn chuột phải → **"Start"**.
   - **`OracleOraDB19Home1TNSListener`** (hoặc tên tương tự chứa "TNSListener") — Phải ở trạng thái **"Running"**. Nếu đang "Stopped", nhấn chuột phải → **"Start"**.
3. Cả hai dịch vụ trên đều phải ở trạng thái **"Running"** thì ứng dụng mới kết nối được database.

> **Mẹo:** Hai dịch vụ này mặc định đã được đặt chế độ **Automatic** (tự khởi động khi bật máy). Nếu muốn chắc chắn, nhấn chuột phải → Properties → đặt **"Startup type"** thành **"Automatic"**.

---

### Bước 8: Khởi chạy ứng dụng 🚀

Đây là bước cuối cùng. Đảm bảo bạn đang ở **thư mục gốc** của dự án (nơi chứa file `package.json`).

1. Gõ lệnh:
   ```
   npm run dev:desktop
   ```

2. Lệnh này sẽ đồng thời khởi động **3 tiến trình**:
   - **Backend** (Node.js Express server) — lắng nghe tại `http://localhost:3000`
   - **Frontend** (Vite dev server) — lắng nghe tại `http://localhost:5173`
   - **Electron** — chờ cả 2 server sẵn sàng rồi mở cửa sổ Desktop App

3. Sau khoảng 5–15 giây, cửa sổ ứng dụng **"Quản Lý Hoạt Động Tình Nguyện Sinh Viên"** sẽ tự động hiện lên với màn hình đăng nhập.

4. **Đăng nhập thử** bằng tài khoản mẫu trong seed data. Ví dụ, mở SQL*Plus để xem danh sách tài khoản:
   ```sql
   SELECT MaTaiKhoan, TenDangNhap, VaiTro FROM TaiKhoan WHERE ROWNUM <= 5;
   ```

5. Để **tắt ứng dụng**, đóng cửa sổ Electron hoặc nhấn `Ctrl + C` trên Terminal đang chạy lệnh.

---

## ⚠️ Xử Lý Sự Cố Thường Gặp

### Lỗi: `ORA-12541: TNS:no listener`
- **Nguyên nhân:** Oracle Listener chưa chạy.
- **Cách sửa:** Mở Terminal với quyền Admin, gõ `lsnrctl start`, hoặc vào Services khởi động dịch vụ TNSListener (xem Bước 7).

### Lỗi: `ORA-01017: invalid username/password`
- **Nguyên nhân:** Chưa tạo user `hqtcsdldb` hoặc sai mật khẩu.
- **Cách sửa:** Thực hiện lại Bước 3.3 (mục 1–3) để tạo user.

### Lỗi: `Cannot find module '...'` khi chạy backend
- **Nguyên nhân:** Chưa cài dependencies cho backend.
- **Cách sửa:** Chạy `cd backend && npm install && cd ..` rồi thử lại.

### Lỗi: `ENOENT: no such file or directory` hoặc `npm ERR!`
- **Nguyên nhân:** Đang chạy lệnh ở sai thư mục.
- **Cách sửa:** Đảm bảo Terminal đang ở thư mục gốc dự án (nơi có file `package.json`). Dùng `cd <đường-dẫn-tới-dự-án>` để di chuyển.

### Lỗi: `concurrently: command not found` hoặc `electron: command not found`
- **Nguyên nhân:** Chưa chạy `npm install` ở thư mục gốc.
- **Cách sửa:** Gõ `npm install` tại thư mục gốc dự án.

### Cửa sổ Electron mở nhưng trắng trơn
- **Nguyên nhân:** Vite dev server hoặc Backend chưa sẵn sàng kịp.
- **Cách sửa:** Đóng cửa sổ, chờ Terminal hiển thị đầy đủ log `Backend is running on port 3000` và `Local: http://localhost:5173/`, sau đó nhấn `Ctrl + C` rồi chạy lại `npm run dev:desktop`.

---

## Tài Liệu

| Tài liệu | Mô tả |
|:---|:---|
| [Database Progress](docs/Database_Progress.md) | Tracker tiến độ & Changelog Database |
| [Project Structure](docs/PROJECT_STRUCTURE.md) | Cấu trúc dự án & thứ tự deploy |
| [Git Guideline](docs/GIT_GUIDELINE.md) | Quy trình Git Flow |
| [Git Commit](docs/GIT_COMMIT.md) | Quy tắc đặt tên commit |
| [List Feat](docs/List_Feat.md) | Danh sách tính năng chi tiết theo phân quyền |
| [Changelog BQL](docs/changelog/module_BQL.md) | Nhật ký thay đổi — Module Ban Quản Lý |
| [Changelog BDH](docs/changelog/module_BDH.md) | Nhật ký thay đổi — Module Ban Điều Hành |
| [Changelog TNV](docs/changelog/module_TNV.md) | Nhật ký thay đổi — Module Tình Nguyện Viên |
| [Changelog Chung](docs/changelog/module_Dungchung.md) | Nhật ký thay đổi — Module Dùng Chung |

## Kiến Trúc Hệ Thống

```
┌─────────────────────────────────────────────────┐
│                  Electron Shell                  │
│  ┌─────────────────┐   ┌──────────────────────┐ │
│  │  React Frontend  │──▶│  Node.js/Express API │ │
│  │  (Vite :5173)    │   │  (Backend :3000)     │ │
│  └─────────────────┘   └──────────┬───────────┘ │
│                                    │             │
│                          ┌─────────▼──────────┐  │
│                          │  Oracle Database    │  │
│                          │  19c (localhost     │  │
│                          │  :1521/orcl)        │  │
│                          └────────────────────┘  │
└─────────────────────────────────────────────────┘
```

## Môi Trường Phát Triển

| Thành phần | Phiên bản khuyến nghị |
|:---|:---|
| **Hệ điều hành** | Windows 10/11 (64-bit) |
| **Node.js** | v20.x LTS hoặc v22.x LTS |
| **npm** | v10.x trở lên (cài kèm Node.js) |
| **Git** | v2.40 trở lên |
| **Oracle Database** | 19c Enterprise/Standard (Non-CDB) |
| **Oracle SID** | `orcl` |
| **Oracle User** | `hqtcsdldb` / `hqtcsdl123` |
| **Oracle Port** | `1521` (mặc định) |
