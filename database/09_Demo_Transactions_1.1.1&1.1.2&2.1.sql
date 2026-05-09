
SET SERVEROUTPUT ON;

-- ============================================================
-- KỊCH BẢN 2 & 3: BẮT ĐẦU VÀ KẾT THÚC TRANSACTION (IMPLICIT COMMIT)
-- Minh họa việc một lệnh DDL tự động Commit lệnh DML trước đó
-- ============================================================

-- Bước 0: Tạm tắt trigger kiểm tra thời gian để khỏi bị chặn lúc demo
ALTER TRIGGER TRG_KIEMTRA_THOIGIAN DISABLE;

-- Bước 1: Kiểm tra trạng thái hiện tại của chiến dịch (Đang là 'DangHoatDong')
SELECT MaChienDich, TenChienDich, TrangThai 
FROM ChienDich 
WHERE MaChienDich = 'CD00000018'; 

-- Bước 2: Quản trị viên cập nhật trạng thái chiến dịch thành 'DaTamDung'. 
UPDATE ChienDich 
SET TrangThai = 'DaTamDung' 
WHERE MaChienDich = 'CD00000018';

-- Bước 3: Đáng lẽ ta phải dùng lệnh COMMIT để lưu, nhưng ta sẽ chạy 1 lệnh DDL.
CREATE TABLE BangTam_TestDemo (Id NUMBER, GhiChu VARCHAR2(50));

-- Bước 4: Kiểm tra lại dữ liệu. Dữ liệu lúc này đã được lưu vĩnh viễn vào DB.
SELECT MaChienDich, TenChienDich, TrangThai 
FROM ChienDich 
WHERE MaChienDich = 'CD00000018';

-- Bước 5: Dọn dẹp môi trường sau khi demo xong (để trả lại trạng thái gốc)
DROP TABLE BangTam_TestDemo;
UPDATE ChienDich SET TrangThai = 'DangHoatDong' WHERE MaChienDich = 'CD00000018';
COMMIT;



-- ============================================================
-- KỊCH BẢN 4: TRANSACTION CONTROL (SỬ DỤNG SAVEPOINT)
-- Minh họa việc lưu các mốc thời gian trong 1 giao dịch dài
-- ============================================================

-- Bước 1: Kiểm tra điểm ban đầu của 2 sinh viên
SELECT MaTaiKhoan, HoTen, TongDiem 
FROM HoSoSinhVien 
WHERE MaTaiKhoan IN (
    (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520001'),
    (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520002')
);

-- Bước 2: Hệ thống cộng 10 điểm cho sinh viên đầu tiên (TNV 1)
UPDATE HoSoSinhVien 
SET TongDiem = NVL(TongDiem, 0) + 10 
WHERE MaTaiKhoan = (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520001');

-- Bước 3: Đánh dấu mốc an toàn (Savepoint) sau khi cộng điểm thành công cho người 1
SAVEPOINT chot_diem_tnv1;

-- Bước 4: Tiếp tục cộng điểm cho người thứ 2, nhưng cố tình gõ sai số (cộng nhầm 1000 điểm)
UPDATE HoSoSinhVien 
SET TongDiem = NVL(TongDiem, 0) + 1000 
WHERE MaTaiKhoan = (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520002');

-- Bước 5: Phát hiện sai sót. Thay vì ROLLBACK toàn bộ làm mất công sức thao tác ở Bước 2,
-- ta chỉ ROLLBACK về mốc savepoint vừa tạo.
ROLLBACK TO SAVEPOINT chot_diem_tnv1;

-- Bước 6: Chốt giao dịch (Chỉ có TNV 1 được cộng 10 điểm, thao tác lỗi ở TNV 2 đã bị hủy)
COMMIT;

-- Bước 7: Kiểm tra lại kết quả để giáo viên thấy rõ sự khác biệt
SELECT MaTaiKhoan, HoTen, TongDiem 
FROM HoSoSinhVien 
WHERE MaTaiKhoan IN (
    (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520001'),
    (SELECT MaTaiKhoan FROM TaiKhoan WHERE TenDangNhap = '22520002')
);
