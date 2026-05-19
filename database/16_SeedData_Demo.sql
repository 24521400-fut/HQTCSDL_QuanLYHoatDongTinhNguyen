SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE OFF
DECLARE
    TYPE t_arr IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    v_tk_admin VARCHAR2(10); v_tk_bdh t_arr; v_tk_tnv t_arr;
    v_dt_ids t_arr; v_loai_ids t_arr; v_cd_ids t_arr;
    v_cv_ids t_arr; v_tg_ids t_arr; v_pc_ids t_arr;
    v_tmp VARCHAR2(10); v_tmp2 VARCHAR2(10);
    v_tn_ids t_arr;
BEGIN
    -- 0A. DISABLE TẤT CA TRIGGERS TRUOC KHI XOA (tranh mutating table)
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_CHANXOA_CHIENDICH DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_THOIGIAN DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_TRUNG_LICH DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY DISABLE';
    -- 0B. XOA DU LIEU CU (cho phep chay lai nhieu lan)
    DELETE FROM ThongBao;
    DELETE FROM TheoDoi;
    DELETE FROM BinhLuan;
    DELETE FROM GiayChungNhan;
    DELETE FROM DiemDanh;
    DELETE FROM PhanCong;
    DELETE FROM ThamGiaTNV;
    DELETE FROM ThanhToan;
    DELETE FROM QuyenGopTien;
    DELETE FROM TaiTro;
    DELETE FROM ChiTieu;
    DELETE FROM MinhChungChiTieu;
    DELETE FROM ChiTietXuatVP;
    DELETE FROM PhieuXuatVatPham;
    DELETE FROM ChiTietQuyenGopVP;
    DELETE FROM PhieuQuyenGopVP;
    DELETE FROM KhoChienDich;
    DELETE FROM CongViec;
    DELETE FROM TinTuc;
    DELETE FROM DuyetChienDich;
    DELETE FROM BanDieuHanh;
    DELETE FROM ChienDich;
    DELETE FROM HoSoSinhVien;
    DELETE FROM NhatKyHeThong;
    DELETE FROM TaiKhoan;
    DELETE FROM DoiTac;
    DELETE FROM LoaiVatPham;
    DELETE FROM ThamSo;
    DBMS_OUTPUT.PUT_LINE('>> Cleanup: OK');
    -- 1. THAM SO
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('TUOI_TOI_THIEU','16','Tuoi toi thieu');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('SO_NHIEM_VU_TOI_DA','5','Max nhiem vu');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('GIO_CONG_MAC_DINH','8','Gio min chung nhan');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('DIEM_XUAT_SAC','9','Diem XuatSac');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('GIO_XUAT_SAC','40','Gio XuatSac');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('DIEM_TOT','7','Diem Tot');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('GIO_TOT','30','Gio Tot');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('DIEM_KHA','5','Diem Kha');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('GIO_KHA','20','Gio Kha');
    INSERT INTO ThamSo(TenThamSo,GiaTri,GhiChu) VALUES('NGUONG_TON_KHO_CANH_BAO','10','Nguong canh bao kho');
    -- 1. ADMIN
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('admin','Admin@123','admin@hssv.vnuhcm.edu.vn','BanQuanLy','HoatDong') RETURNING MaTaiKhoan INTO v_tk_admin;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tk_admin,N'Admin HSSV','AD000',DATE '1990-01-01',N'Nam',N'Ban Quan Ly','Admin','0901000000',N'DHQG-HCM');
    -- 2. BAN DIEU HANH
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh01','Bdh01@123','bdh01@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(1):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Tran Hoai Nam','DH001',DATE '2000-03-15',N'Nam',N'Hoi Sinh Vien','BCH2022','0912001001',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh02','Bdh02@123','bdh02@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(2):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Nguyen Thi Bich Phuong','DH002',DATE '2000-05-20',N'Nu',N'Hoi Sinh Vien','BCH2022','0912001002',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh03','Bdh03@123','bdh03@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(3):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Le Quang Trung','DH003',DATE '2000-01-10',N'Nam',N'Hoi Sinh Vien','BCH2022','0912001003',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh04','Bdh04@123','bdh04@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(4):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Pham Thi Ngoc Han','DH004',DATE '2000-07-25',N'Nu',N'Hoi Sinh Vien','BCH2022','0912001004',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh05','Bdh05@123','bdh05@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(5):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Vo Minh Hieu','DH005',DATE '2000-09-08',N'Nam',N'Hoi Sinh Vien','BCH2022','0912001005',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh06','Bdh06@123','bdh06@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(6):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Do Thi Thanh Tam','DH006',DATE '2000-11-12',N'Nu',N'Hoi Sinh Vien','BCH2022','0912001006',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh07','Bdh07@123','bdh07@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(7):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Hoang Van Thinh','DH007',DATE '2000-02-28',N'Nam',N'Hoi Sinh Vien','BCH2022','0912001007',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh08','Bdh08@123','bdh08@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(8):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Truong Thi Kim Ngan','DH008',DATE '2000-04-18',N'Nu',N'Hoi Sinh Vien','BCH2022','0912001008',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh09','Bdh09@123','bdh09@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(9):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ngo Quoc Toan','DH009',DATE '2000-06-30',N'Nam',N'Hoi Sinh Vien','BCH2022','0912001009',N'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('bdh10','Bdh10@123','bdh10@hssv.vnuhcm.edu.vn','BanDieuHanh','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_bdh(10):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ly Thi Anh Tuyet','DH010',DATE '2000-08-14',N'Nu',N'Hoi Sinh Vien','BCH2022','0912001010',N'TP.HCM');
    DBMS_OUTPUT.PUT_LINE('>> TaiKhoan Admin+BDH: OK');
    -- 3. TINH NGUYEN VIEN (40 TNV)
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv01','Tnv01@123','22520101@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(1):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Nguyen Minh Khoa','22520101',DATE '2004-03-15',N'Nam',N'Khoa CNTT','KTPM2022','0988101001',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv02','Tnv02@123','22520102@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(2):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Tran Thi Lan Anh','22520102',DATE '2004-05-20',N'Nu',N'Khoa CNTT','KTPM2022','0988101002',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv03','Tnv03@123','22520103@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(3):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Le Van Hung','22520103',DATE '2004-01-10',N'Nam',N'Khoa CNTT','KTPM2022','0988101003',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv04','Tnv04@123','22520104@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(4):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Pham Thi Thu Ha','22520104',DATE '2004-07-25',N'Nu',N'Khoa CNTT','KTPM2022','0988101004',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv05','Tnv05@123','22520105@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(5):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Hoang Duc Manh','22520105',DATE '2004-09-08',N'Nam',N'Khoa CNTT','KTPM2022','0988101005',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv06','Tnv06@123','22520106@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(6):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Vu Thi Ngoc Mai','22520106',DATE '2004-11-12',N'Nu',N'Khoa CNTT','KTPM2022','0988101006',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv07','Tnv07@123','22520107@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(7):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Dang Van Tung','22520107',DATE '2004-02-28',N'Nam',N'Khoa CNTT','KTPM2022','0988101007',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv08','Tnv08@123','22520108@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(8):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Bui Thi Kim Chi','22520108',DATE '2004-04-18',N'Nu',N'Khoa CNTT','KTPM2022','0988101008',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv09','Tnv09@123','22520109@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(9):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ngo Van Binh','22520109',DATE '2004-06-30',N'Nam',N'Khoa CNTT','KTPM2022','0988101009',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv10','Tnv10@123','22520110@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(10):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ly Thi Hong Nhung','22520110',DATE '2004-08-14',N'Nu',N'Khoa CNTT','KTPM2022','0988101010',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv11','Tnv11@123','22520111@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(11):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Phan Van Dung','22520111',DATE '2004-10-05',N'Nam',N'Khoa CNTT','KTPM2022','0988101011',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv12','Tnv12@123','22520112@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(12):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Truong Thi Thao','22520112',DATE '2004-12-22',N'Nu',N'Khoa CNTT','KTPM2022','0988101012',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv13','Tnv13@123','22520113@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(13):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Dinh Quang Huy','22520113',DATE '2004-03-07',N'Nam',N'Khoa CNTT','KTPM2022','0988101013',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv14','Tnv14@123','22520114@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(14):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Mai Thi Phuong','22520114',DATE '2004-05-19',N'Nu',N'Khoa CNTT','KTPM2022','0988101014',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv15','Tnv15@123','22520115@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(15):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Chu Van Dat','22520115',DATE '2004-07-31',N'Nam',N'Khoa CNTT','KTPM2022','0988101015',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv16','Tnv16@123','22520116@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(16):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Vo Thi Cam Tu','22520116',DATE '2004-09-16',N'Nu',N'Khoa CNTT','KTPM2022','0988101016',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv17','Tnv17@123','22520117@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(17):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Duong Minh Tuan','22520117',DATE '2004-11-27',N'Nam',N'Khoa CNTT','KTPM2022','0988101017',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv18','Tnv18@123','22520118@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(18):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ho Thi Thanh Thao','22520118',DATE '2004-01-23',N'Nu',N'Khoa CNTT','KTPM2022','0988101018',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv19','Tnv19@123','22520119@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(19):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Luu Van Khai','22520119',DATE '2004-04-09',N'Nam',N'Khoa CNTT','KTPM2022','0988101019',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv20','Tnv20@123','22520120@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(20):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ta Thi Bich Ngoc','22520120',DATE '2004-06-17',N'Nu',N'Khoa CNTT','KTPM2022','0988101020',N'KTX Khu A DHQG-HCM');
    DBMS_OUTPUT.PUT_LINE('>> TNV 01-20: OK');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv21','Tnv21@123','22520121@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(21):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Tran Van Phuc','22520121',DATE '2004-08-03',N'Nam',N'Khoa CNTT','KTPM2022','0988101021',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv22','Tnv22@123','22520122@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(22):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Nguyen Thi Dieu Linh','22520122',DATE '2004-10-29',N'Nu',N'Khoa CNTT','KTPM2022','0988101022',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv23','Tnv23@123','22520123@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(23):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Do Quoc Hung','22520123',DATE '2004-12-11',N'Nam',N'Khoa CNTT','KTPM2022','0988101023',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv24','Tnv24@123','22520124@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(24):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Cao Thi Thu Trang','22520124',DATE '2004-02-06',N'Nu',N'Khoa CNTT','KTPM2022','0988101024',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv25','Tnv25@123','22520125@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(25):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Huynh Van Tai','22520125',DATE '2004-04-24',N'Nam',N'Khoa CNTT','KTPM2022','0988101025',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv26','Tnv26@123','22520126@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(26):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Tran Thi Bao Chau','22520126',DATE '2004-06-08',N'Nu',N'Khoa CNTT','KTPM2022','0988101026',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv27','Tnv27@123','22520127@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(27):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Kieu Minh Nhat','22520127',DATE '2004-08-20',N'Nam',N'Khoa CNTT','KTPM2022','0988101027',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv28','Tnv28@123','22520128@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(28):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Vo Thi Ha My','22520128',DATE '2004-10-13',N'Nu',N'Khoa CNTT','KTPM2022','0988101028',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv29','Tnv29@123','22520129@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(29):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Le Hoang Nam','22520129',DATE '2004-12-01',N'Nam',N'Khoa CNTT','KTPM2022','0988101029',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv30','Tnv30@123','22520130@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(30):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Phan Thi Kim Dung','22520130',DATE '2004-02-15',N'Nu',N'Khoa CNTT','KTPM2022','0988101030',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv31','Tnv31@123','22520131@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(31):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Nguyen Quang Vinh','22520131',DATE '2004-04-30',N'Nam',N'Khoa CNTT','KTPM2022','0988101031',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv32','Tnv32@123','22520132@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(32):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Dinh Thi Phuc An','22520132',DATE '2004-07-12',N'Nu',N'Khoa CNTT','KTPM2022','0988101032',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv33','Tnv33@123','22520133@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(33):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Bui Van Cuong','22520133',DATE '2004-09-25',N'Nam',N'Khoa CNTT','KTPM2022','0988101033',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv34','Tnv34@123','22520134@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(34):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Le Thi My Hanh','22520134',DATE '2004-11-08',N'Nu',N'Khoa CNTT','KTPM2022','0988101034',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv35','Tnv35@123','22520135@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(35):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'To Minh Duc','22520135',DATE '2004-01-17',N'Nam',N'Khoa CNTT','KTPM2022','0988101035',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv36','Tnv36@123','22520136@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(36):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Hua Thi Ngoc Tuyen','22520136',DATE '2004-03-28',N'Nu',N'Khoa CNTT','KTPM2022','0988101036',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv37','Tnv37@123','22520137@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(37):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Pham Van Khanh','22520137',DATE '2004-05-14',N'Nam',N'Khoa CNTT','KTPM2022','0988101037',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv38','Tnv38@123','22520138@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(38):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Doan Thi Lan Chi','22520138',DATE '2004-07-06',N'Nu',N'Khoa CNTT','KTPM2022','0988101038',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv39','Tnv39@123','22520139@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(39):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Ha Van Long','22520139',DATE '2004-09-19',N'Nam',N'Khoa CNTT','KTPM2022','0988101039',N'KTX Khu A DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap,MatKhau,Email,VaiTro,TrangThai) VALUES('tnv40','Tnv40@123','22520140@gm.uit.edu.vn','TinhNguyenVien','HoatDong') RETURNING MaTaiKhoan INTO v_tmp; v_tk_tnv(40):=v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan,HoTen,MSSV,NgaySinh,GioiTinh,Khoa,Lop,SoDienThoai,DiaChi) VALUES(v_tmp,N'Nguyen Thi Yen Nhi','22520140',DATE '2004-11-30',N'Nu',N'Khoa CNTT','KTPM2022','0988101040',N'KTX Khu A DHQG-HCM');
    DBMS_OUTPUT.PUT_LINE('>> TNV 21-40: OK');
    -- 4. DOI TAC
    INSERT INTO DoiTac(TenDoiTac,LinhVuc,SoDienThoai,Email,DiaChi) VALUES(N'Hoi Sinh Vien DHQG-HCM',N'To chuc sinh vien','02838647256','hsv@vnuhcm.edu.vn',N'Linh Trung, Thu Duc') RETURNING MaDoiTac INTO v_tmp; v_dt_ids(1):=v_tmp;
    INSERT INTO DoiTac(TenDoiTac,LinhVuc,SoDienThoai,Email,DiaChi) VALUES(N'Ngan hang Agribank - CN Dong SG',N'Tai tro tai chinh','02838960123','dongsg@agribank.com.vn',N'TP.Thu Duc') RETURNING MaDoiTac INTO v_tmp; v_dt_ids(2):=v_tmp;
    INSERT INTO DoiTac(TenDoiTac,LinhVuc,SoDienThoai,Email,DiaChi) VALUES(N'Cong ty Co phan Sua Vinamilk',N'Tai tro nhu yeu pham','02854155555','cskh@vinamilk.com.vn',N'Quan 7, TP.HCM') RETURNING MaDoiTac INTO v_tmp; v_dt_ids(3):=v_tmp;
    -- 5. LOAI VAT PHAM
    INSERT INTO LoaiVatPham(TenLoai,DonViTinh,SoLuongTon) VALUES(N'Ao Mua He Xanh',N'Cai',0) RETURNING MaLoai INTO v_tmp; v_loai_ids(1):=v_tmp;
    INSERT INTO LoaiVatPham(TenLoai,DonViTinh,SoLuongTon) VALUES(N'Non tai beo tinh nguyen',N'Cai',0) RETURNING MaLoai INTO v_tmp; v_loai_ids(2):=v_tmp;
    INSERT INTO LoaiVatPham(TenLoai,DonViTinh,SoLuongTon) VALUES(N'Nuoc suoi dong chai',N'Thung',0) RETURNING MaLoai INTO v_tmp; v_loai_ids(3):=v_tmp;
    INSERT INTO LoaiVatPham(TenLoai,DonViTinh,SoLuongTon) VALUES(N'Sua hop Vinamilk',N'Thung',0) RETURNING MaLoai INTO v_tmp; v_loai_ids(4):=v_tmp;
    INSERT INTO LoaiVatPham(TenLoai,DonViTinh,SoLuongTon) VALUES(N'Ao am mua dong',N'Cai',0) RETURNING MaLoai INTO v_tmp; v_loai_ids(5):=v_tmp;
    DBMS_OUTPUT.PUT_LINE('>> DoiTac + LoaiVatPham: OK');
    -- 6. CHIEN DICH (10 CD: 7 DaKetThuc, 3 DangHoatDong)
    -- CD1: Xuan Tinh Nguyen 2024 - KTX DHQG-HCM (DaKetThuc)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Xuan Tinh Nguyen 2024 - KTX DHQG-HCM',DATE '2024-01-15',DATE '2024-02-10',N'Mang khong khi xuan den sinh vien xa nha tai KTX DHQG-HCM.',N'KTX Khu A, DHQG-HCM',80,20000000,'DaKetThuc',v_tk_bdh(1),8,1)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(1):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(1),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-01-10',N'Duyet chuan bi tet 2024');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Truyen Thong & Ghi Hinh',N'Chup anh, quay phim, post bai MXH',10,TIMESTAMP '2024-01-15 07:00:00',TIMESTAMP '2024-02-10 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(1):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Hau Can & Phat Qua',N'Chuan bi va phat qua cho sinh vien',10,TIMESTAMP '2024-01-15 07:00:00',TIMESTAMP '2024-02-10 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(2):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Phat dong Xuan Tinh Nguyen 2024 tai KTX DHQG-HCM',N'Chuong trinh Xuan Tinh Nguyen 2024 chinh thuc phat dong, mang khong khi tet den voi hon 5000 sinh vien noi tru tai KTX DHQG-HCM.',v_tk_bdh(1)) RETURNING MaTinTuc INTO v_tn_ids(1);
    -- CD2: Mua He Xanh 2024 - Ben Tre (DaKetThuc)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Mua He Xanh 2024 - Mat tran tinh Ben Tre',DATE '2024-07-01',DATE '2024-08-01',N'Xay dung cau duong nong thon, thap sang duong que va day hoc cho tre em tai Ben Tre.',N'Huyen Lai Vung, Ben Tre',120,100000000,'DaKetThuc',v_tk_bdh(2),30,3)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(2):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(2),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-06-20',N'Duyet MHX 2024 Ben Tre');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Xay Dung & Lao Dong',N'Tham gia xay dung cau duong, cong trinh cong cong',15,TIMESTAMP '2024-07-01 06:00:00',TIMESTAMP '2024-08-01 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(3):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Day Hoc & Giao Duc',N'Day tieng Anh, toan, van cho hoc sinh vung sau',10,TIMESTAMP '2024-07-01 07:30:00',TIMESTAMP '2024-08-01 17:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(4):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Chien dich Mua He Xanh 2024 chinh thuc khoi dong tai Ben Tre',N'Gan 120 tinh nguyen vien UIT len duong trong chuyen hanh trinh y nghia tai Ben Tre. Chien dich se tap trung xay dung co so ha tang nong thon va giao duc.',v_tk_bdh(2)) RETURNING MaTinTuc INTO v_tn_ids(2);
    -- CD3: Tiep Suc Mua Thi 2024 (DaKetThuc)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Tiep Suc Mua Thi 2024 - Cum thi DHQG-HCM',DATE '2024-06-25',DATE '2024-07-05',N'Ho tro thi sinh tham du ky thi THPT Quoc gia tai cum thi Lang Dai Hoc.',N'Lang Dai hoc DHQG-HCM',200,25000000,'DaKetThuc',v_tk_bdh(3),15,2)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(3):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(3),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-06-15',N'Duyet TSMT 2024');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Dan Duong & Ho Tro Thi Sinh',N'Huong dan thi sinh tim phong thi, van chuyen',20,TIMESTAMP '2024-06-25 05:30:00',TIMESTAMP '2024-07-05 12:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(5):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Phat Do An & Nuoc Uong',N'Phat com, nuoc, khan lanh cho thi sinh',20,TIMESTAMP '2024-06-25 05:30:00',TIMESTAMP '2024-07-05 12:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(6):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Tiep Suc Mua Thi 2024 - Dong hanh cung si tu DHQG-HCM',N'200 tinh nguyen vien UIT san sang dong hanh cung hon 10.000 thi sinh THPT tai cum thi DHQG-HCM.',v_tk_bdh(3)) RETURNING MaTinTuc INTO v_tn_ids(3);
    DBMS_OUTPUT.PUT_LINE('>> CD 1-3: OK');
    -- CD4: Chu Nhat Xanh - Trong cay 2024 (DaKetThuc, 1 ngay)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Chu Nhat Xanh dot 1/2024 - Trong cay va don dep',DATE '2024-03-10',DATE '2024-03-10',N'Don dep rac thai va trong cay xanh quanh khu vuc ho Da va Lang Dai Hoc.',N'Ho Da, DHQG-HCM',150,5000000,'DaKetThuc',v_tk_bdh(4),4,1)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(4):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(4),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-03-05',N'Duyet CNX dot 1');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Don Ve Sinh & Thu Gom Rac',N'Thu gom rac, don dep khu vuc ho Da',20,TIMESTAMP '2024-03-10 07:00:00',TIMESTAMP '2024-03-10 11:30:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(7):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Trong Cay Xanh',N'Trong cay bong mat, cay canh xanh',10,TIMESTAMP '2024-03-10 08:00:00',TIMESTAMP '2024-03-10 12:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(8):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Chu Nhat Xanh 2024 - UIT gop suc xay dung Campus xanh sach dep',N'Trong ngay Chu Nhat 10/3, hon 150 tinh nguyen vien UIT da don dep va trong them 200 cay xanh quanh khu vuc DHQG-HCM.',v_tk_bdh(4));
    -- CD5: Hien Mau Nhan Dao dot 1/2024 (DaKetThuc, 1 ngay)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Ngay hoi Hien Mau Nhan Dao dot 1/2024',DATE '2024-04-14',DATE '2024-04-14',N'Hien mau cuu nguoi tai Nha dieu hanh DHQG-HCM. Muc tieu 500 don vi mau.',N'Nha Dieu Hanh DHQG-HCM',300,10000000,'DaKetThuc',v_tk_bdh(5),4,1)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(5):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(5),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-04-08',N'Duyet hien mau dot 1');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Tiep Don & Dang Ky',N'Tiep nhan, dang ky thong tin nguoi hien mau',15,TIMESTAMP '2024-04-14 07:00:00',TIMESTAMP '2024-04-14 16:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(9):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Cham Soc & Phuc Hoi',N'Cham soc nguoi hien mau sau khi hien, phat do an boi duong',10,TIMESTAMP '2024-04-14 07:30:00',TIMESTAMP '2024-04-14 16:30:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(10):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Ket qua Ngay hoi Hien Mau dot 1/2024: 487 don vi mau',N'Ngay hoi hien mau nhan dao da thu duoc 487 don vi mau, vuot 97% muc tieu de ra. Cam on tat ca tinh nguyen vien va nguoi hien mau!',v_tk_bdh(5));
    -- CD6: Ao am Mua Dong 2024 (DaKetThuc)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Ao am Mua Dong 2024 - Suoi am vung cao Ha Giang',DATE '2024-11-01',DATE '2024-12-15',N'Quyen gop va van chuyen ao am, nhu yeu pham gui tang dong bao vung cao Ha Giang.',N'Ha Giang',60,50000000,'DaKetThuc',v_tk_bdh(6),20,2)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(6):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(6),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-10-25',N'Duyet ao am 2024');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Quyen Gop & Phan Loai',N'Tiep nhan, phan loai ao quan quyen gop',10,TIMESTAMP '2024-11-01 08:00:00',TIMESTAMP '2024-12-10 17:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(11):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Van Chuyen & Phat Qua',N'Dong goi va phat ao am den tay nguoi dan',10,TIMESTAMP '2024-11-15 06:00:00',TIMESTAMP '2024-12-15 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(12):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Chien dich Ao am Mua Dong 2024 - UIT gui yeu thuong den Ha Giang',N'Hon 2000 ao am va qua tang da duoc gui den dong bao vung cao Ha Giang trong doi ret lich su nam 2024.',v_tk_bdh(6));
    -- CD7: Khac phuc Bao lu mien Trung 2024 (DaKetThuc)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Khac phuc hau qua bao lu mien Trung 2024',DATE '2024-10-20',DATE '2024-11-20',N'Huy dong nhan luc va vat chat ho tro dong bao mien Trung bi anh huong nang ne boi bao.',N'Quang Nam, Quang Ngai',200,500000000,'DaKetThuc',v_tk_bdh(7),50,5)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(7):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(7),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2024-10-18',N'Duyet khan cap bao lu mien Trung');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Cuu Tro Tai Hien Truong',N'Truc tiep don dep, sua chua nha cua, ho tro dan cu',25,TIMESTAMP '2024-10-20 06:00:00',TIMESTAMP '2024-11-20 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(13):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Quyen Gop & Hau Can',N'Tieu thu, phan phoi luong thuc thuc pham cho ba con',20,TIMESTAMP '2024-10-20 07:00:00',TIMESTAMP '2024-11-20 17:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(14):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'UIT chung tay khac phuc bao lu mien Trung - Lan song yeu thuong',N'200 tinh nguyen vien UIT da co mat tai Quang Nam va Quang Ngai ngay sau con bao, mang theo 500 trieu dong quyen gop va hang tan nhu yeu pham.',v_tk_bdh(7)) RETURNING MaTinTuc INTO v_tn_ids(7);
    DBMS_OUTPUT.PUT_LINE('>> CD 4-7: OK');
    -- CD8: Xuan Tinh Nguyen 2025 (DangHoatDong)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Xuan Tinh Nguyen 2025 - Ket noi yeu thuong',DATE '2025-01-20',DATE '2025-02-15',N'Chuong trinh don Tet 2025 danh cho sinh vien xa nha tai KTX: goi qua tet, lien hoan van nghe va tham hoi ba con kho khan.',N'KTX Khu A-B, DHQG-HCM',100,30000000,'DangHoatDong',v_tk_bdh(8),8,1)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(8):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(8),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2025-01-15',N'Duyet XTN 2025');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Truyen Thong & Su Kien',N'Truyen thong, to chuc le khai mac, van nghe',12,TIMESTAMP '2025-01-20 08:00:00',TIMESTAMP '2025-02-15 18:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(15):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Goi Qua & Hau Can',N'Chuan bi va phat goi qua tet cho sinh vien',12,TIMESTAMP '2025-01-20 07:00:00',TIMESTAMP '2025-02-15 17:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(16):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Mo dang ky Xuan Tinh Nguyen 2025 - Han chot 18/01/2025',N'Ban To chuc mo dang ky tinh nguyen vien tham gia Xuan Tinh Nguyen 2025. Han chot dang ky: 18/01/2025. So luong co han 100 nguoi.',v_tk_bdh(8)) RETURNING MaTinTuc INTO v_tn_ids(8);
    -- CD9: Tiep Suc Mua Thi 2025 (DangHoatDong)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Tiep Suc Mua Thi 2025 - Ky thi THPT Quoc gia',DATE '2025-06-25',DATE '2025-07-10',N'Ho tro thi sinh du thi THPT Quoc gia nam 2025 tai cum thi Lang Dai Hoc DHQG-HCM.',N'Lang Dai hoc DHQG-HCM',250,30000000,'DangHoatDong',v_tk_bdh(9),15,2)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(9):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(9),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2025-06-10',N'Duyet TSMT 2025');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Dan Duong & Ho Tro Thi Sinh',N'Huong dan va van chuyen thi sinh',30,TIMESTAMP '2025-06-25 05:00:00',TIMESTAMP '2025-07-10 12:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(17):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Hau Can & Cham Lo',N'Phat nuoc, com, quat mat cho thi sinh',30,TIMESTAMP '2025-06-25 05:00:00',TIMESTAMP '2025-07-10 13:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(18):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Tuyen tinh nguyen vien Tiep Suc Mua Thi 2025',N'UIT tiep tuc trien khai chuong trinh Tiep Suc Mua Thi 2025 voi quy mo 250 tinh nguyen vien, phuc vu gan 12.000 thi sinh THPT tai khu vuc DHQG-HCM.',v_tk_bdh(9));
    -- CD10: Hien Mau Nhan Dao dot 1/2025 (DangHoatDong)
    INSERT INTO ChienDich(TenChienDich,NgayBatDau,NgayKetThuc,MoTa,DiaDiem,SoLuongTNVToiDa,MucTieuTien,TrangThai,MaNguoiTao,GioToiThieuCN,DiemThuong)
    VALUES(N'Ngay hoi Hien Mau Nhan Dao dot 1/2025',DATE '2025-04-06',DATE '2025-04-06',N'Tiep noi truyen thong hien mau cuu nguoi. Muc tieu 600 don vi mau tai Nha Dieu Hanh DHQG-HCM.',N'Nha Dieu Hanh DHQG-HCM',350,12000000,'DangHoatDong',v_tk_bdh(10),4,1)
    RETURNING MaChienDich INTO v_tmp; v_cd_ids(10):=v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan,MaChienDich) VALUES(v_tk_bdh(10),v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich,MaNguoiDuyet,TrangThai,NgayDuyet,GhiChu) VALUES(v_tmp,v_tk_admin,'DaDuyet',DATE '2025-03-28',N'Duyet hien mau dot 1/2025');
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Tiep Tan & Dang Ky',N'Don tiep, huong dan dang ky nguoi hien mau',20,TIMESTAMP '2025-04-06 06:30:00',TIMESTAMP '2025-04-06 16:30:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(19):=v_tmp2;
    INSERT INTO CongViec(MaChienDich,TenCongViec,MoTa,SoLuongTNVCan,ThoiGianBatDau,ThoiGianKetThuc) VALUES(v_tmp,N'Ban Cham Soc Sau Hien',N'Cham soc, phat do an boi duong sau hien mau',15,TIMESTAMP '2025-04-06 07:00:00',TIMESTAMP '2025-04-06 17:00:00') RETURNING MaCongViec INTO v_tmp2; v_cv_ids(20):=v_tmp2;
    INSERT INTO TinTuc(MaChienDich,TieuDe,NoiDung,MaNguoiDang) VALUES(v_tmp,N'Ngay hoi Hien Mau 2025 - Giot mau nghia tinh, cuoc doi hoi sinh',N'Ngay hoi hien mau dot 1/2025 se duoc to chuc vao ngay 06/04. Hay dang ky tham gia de gop them nhung giot mau quy gia!',v_tk_bdh(10));
    DBMS_OUTPUT.PUT_LINE('>> CD 8-10: OK');
    -- 7. THAM GIA TNV + PHAN CONG + DIEM DANH (cho 7 chien dich da ket thuc)
    -- CD1 (Xuan TN 2024, Jan-Feb): tnv01,02,03,04 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(1),v_cd_ids(1),'HoanThanh',DATE '2024-01-10') RETURNING MaThamGia INTO v_tmp; v_tg_ids(1):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(1),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2; v_pc_ids(1):=v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-15','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-22','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-02-05','CoMat',8);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(2),v_cd_ids(1),'HoanThanh',DATE '2024-01-10') RETURNING MaThamGia INTO v_tmp; v_tg_ids(2):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(2),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2; v_pc_ids(2):=v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-15','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-22','CoMat',7);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-02-05','VangMat',0);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(3),v_cd_ids(1),'HoanThanh',DATE '2024-01-11') RETURNING MaThamGia INTO v_tmp; v_tg_ids(3):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(1),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2; v_pc_ids(3):=v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-15','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-22','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-02-05','CoMat',6);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(4),v_cd_ids(1),'HoanThanh',DATE '2024-01-12') RETURNING MaThamGia INTO v_tmp; v_tg_ids(4):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(2),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2; v_pc_ids(4):=v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-01-15','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-02-05','CoMat',8);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(1);
    UPDATE ThamGiaTNV SET DiemDanhGia=7 WHERE MaThamGia=v_tg_ids(2);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(3);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(4);
    -- CD2 (Mua He Xanh, Jul): tnv05,06,07,08 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(5),v_cd_ids(2),'HoanThanh',DATE '2024-06-20') RETURNING MaThamGia INTO v_tmp; v_tg_ids(5):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(3),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-01','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-08','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-15','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-22','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-29','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(6),v_cd_ids(2),'HoanThanh',DATE '2024-06-20') RETURNING MaThamGia INTO v_tmp; v_tg_ids(6):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(4),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-01','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-08','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-15','CoPhep',4);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-22','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-29','CoMat',8);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(7),v_cd_ids(2),'HoanThanh',DATE '2024-06-21') RETURNING MaThamGia INTO v_tmp; v_tg_ids(7):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(3),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-01','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-08','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-15','VangMat',0);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-22','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-29','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(8),v_cd_ids(2),'HoanThanh',DATE '2024-06-22') RETURNING MaThamGia INTO v_tmp; v_tg_ids(8):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(4),'HoanThanh') RETURNING MaPhanCong INTO v_tmp2;
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-01','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-15','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-29','CoMat',8);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(5);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(6);
    UPDATE ThamGiaTNV SET DiemDanhGia=7 WHERE MaThamGia=v_tg_ids(7);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(8);
    DBMS_OUTPUT.PUT_LINE('>> ThamGia CD1-2: OK');
    -- CD3 (TSMT 2024, Jun-Jul): tnv09,10,11,12 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(9),v_cd_ids(3),'HoanThanh',DATE '2024-06-15') RETURNING MaThamGia INTO v_tmp; v_tg_ids(9):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(5),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-25','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-26','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-02','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-03','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(10),v_cd_ids(3),'HoanThanh',DATE '2024-06-15') RETURNING MaThamGia INTO v_tmp; v_tg_ids(10):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(6),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-25','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-26','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-02','CoPhep',5);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-03','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(11),v_cd_ids(3),'HoanThanh',DATE '2024-06-16') RETURNING MaThamGia INTO v_tmp; v_tg_ids(11):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(5),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-25','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-26','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-02','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-03','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(12),v_cd_ids(3),'HoanThanh',DATE '2024-06-17') RETURNING MaThamGia INTO v_tmp; v_tg_ids(12):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(6),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-25','VangMat',0);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-06-26','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-02','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-07-03','CoMat',10);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(9);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(10);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(11);
    UPDATE ThamGiaTNV SET DiemDanhGia=7 WHERE MaThamGia=v_tg_ids(12);
    -- CD4 (Chu Nhat Xanh, Mar 10): tnv01,05,13 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(1),v_cd_ids(4),'HoanThanh',DATE '2024-03-05') RETURNING MaThamGia INTO v_tmp; v_tg_ids(13):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(7),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-03-10','CoMat',5);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(5),v_cd_ids(4),'HoanThanh',DATE '2024-03-05') RETURNING MaThamGia INTO v_tmp; v_tg_ids(14):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(8),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-03-10','CoMat',5);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(13),v_cd_ids(4),'HoanThanh',DATE '2024-03-06') RETURNING MaThamGia INTO v_tmp; v_tg_ids(15):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(7),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-03-10','CoMat',5);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(13);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(14);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(15);
    -- CD5 (Hien Mau 2024, Apr 14): tnv02,06,14,15 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(2),v_cd_ids(5),'HoanThanh',DATE '2024-04-08') RETURNING MaThamGia INTO v_tmp; v_tg_ids(16):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(9),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-04-14','CoMat',9);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(6),v_cd_ids(5),'HoanThanh',DATE '2024-04-08') RETURNING MaThamGia INTO v_tmp; v_tg_ids(17):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(10),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-04-14','CoMat',9);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(14),v_cd_ids(5),'HoanThanh',DATE '2024-04-09') RETURNING MaThamGia INTO v_tmp; v_tg_ids(18):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(9),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-04-14','CoMat',9);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(15),v_cd_ids(5),'HoanThanh',DATE '2024-04-10') RETURNING MaThamGia INTO v_tmp; v_tg_ids(19):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(10),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-04-14','CoMat',9);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(16);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(17);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(18);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(19);
    DBMS_OUTPUT.PUT_LINE('>> ThamGia CD3-5: OK');
    -- CD6 (Ao am 2024, Nov-Dec): tnv16,17,18,19 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(16),v_cd_ids(6),'HoanThanh',DATE '2024-10-25') RETURNING MaThamGia INTO v_tmp; v_tg_ids(20):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(11),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-03','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-10','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-17','CoMat',8);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(17),v_cd_ids(6),'HoanThanh',DATE '2024-10-25') RETURNING MaThamGia INTO v_tmp; v_tg_ids(21):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(12),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-17','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-12-01','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-12-08','CoMat',8);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(18),v_cd_ids(6),'HoanThanh',DATE '2024-10-26') RETURNING MaThamGia INTO v_tmp; v_tg_ids(22):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(11),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-03','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-10','CoPhep',4);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-17','CoMat',8);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(19),v_cd_ids(6),'HoanThanh',DATE '2024-10-27') RETURNING MaThamGia INTO v_tmp; v_tg_ids(23):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(12),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-17','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-12-01','CoMat',8);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-12-08','CoMat',8);
    UPDATE ThamGiaTNV SET DiemDanhGia=9 WHERE MaThamGia=v_tg_ids(20);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(21);
    UPDATE ThamGiaTNV SET DiemDanhGia=7 WHERE MaThamGia=v_tg_ids(22);
    UPDATE ThamGiaTNV SET DiemDanhGia=8 WHERE MaThamGia=v_tg_ids(23);
    -- CD7 (Bao lu 2024, Oct-Nov): tnv20,21,22,23 -> HoanThanh
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(20),v_cd_ids(7),'HoanThanh',DATE '2024-10-18') RETURNING MaThamGia INTO v_tmp; v_tg_ids(24):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(13),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-21','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-28','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-04','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-11','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(21),v_cd_ids(7),'HoanThanh',DATE '2024-10-18') RETURNING MaThamGia INTO v_tmp; v_tg_ids(25):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(14),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-21','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-28','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-04','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-11','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(22),v_cd_ids(7),'HoanThanh',DATE '2024-10-19') RETURNING MaThamGia INTO v_tmp; v_tg_ids(26):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(13),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-21','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-28','VangMat',0);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-04','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-11','CoMat',10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(23),v_cd_ids(7),'HoanThanh',DATE '2024-10-19') RETURNING MaThamGia INTO v_tmp; v_tg_ids(27):=v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(14),'HoanThanh');
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-21','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-10-28','CoMat',10);
    INSERT INTO DiemDanh(MaThamGia,NgayDiemDanh,TrangThai,SoGioGhiNhan) VALUES(v_tmp,DATE '2024-11-11','CoMat',10);
    UPDATE ThamGiaTNV SET DiemDanhGia=10 WHERE MaThamGia=v_tg_ids(24);
    UPDATE ThamGiaTNV SET DiemDanhGia=9  WHERE MaThamGia=v_tg_ids(25);
    UPDATE ThamGiaTNV SET DiemDanhGia=8  WHERE MaThamGia=v_tg_ids(26);
    UPDATE ThamGiaTNV SET DiemDanhGia=9  WHERE MaThamGia=v_tg_ids(27);
    DBMS_OUTPUT.PUT_LINE('>> ThamGia CD6-7: OK');
    -- 8. CHIEN DICH DANG HOAT DONG: CD8,9,10 - DaDuyet + ChoDuyet
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(24),v_cd_ids(8),'DaDuyet',DATE '2025-01-16') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(15),'DangThucHien');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(25),v_cd_ids(8),'DaDuyet',DATE '2025-01-16') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(16),'DangThucHien');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(26),v_cd_ids(8),'DaDuyet',DATE '2025-01-17') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(15),'DangThucHien');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(27),v_cd_ids(8),'ChoDuyet',DATE '2025-01-18');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(28),v_cd_ids(8),'ChoDuyet',DATE '2025-01-18');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(29),v_cd_ids(9),'DaDuyet',DATE '2025-06-11') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(17),'ChuaBatDau');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(30),v_cd_ids(9),'DaDuyet',DATE '2025-06-11') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(18),'ChuaBatDau');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(31),v_cd_ids(9),'ChoDuyet',DATE '2025-06-12');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(32),v_cd_ids(9),'ChoDuyet',DATE '2025-06-12');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(33),v_cd_ids(10),'DaDuyet',DATE '2025-03-29') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(19),'ChuaBatDau');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(34),v_cd_ids(10),'DaDuyet',DATE '2025-03-29') RETURNING MaThamGia INTO v_tmp;
    INSERT INTO PhanCong(MaThamGia,MaCongViec,TrangThai) VALUES(v_tmp,v_cv_ids(20),'ChuaBatDau');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(35),v_cd_ids(10),'ChoDuyet',DATE '2025-03-30');
    INSERT INTO ThamGiaTNV(MaTaiKhoan,MaChienDich,TrangThaiDuyet,NgayDangKy) VALUES(v_tk_tnv(36),v_cd_ids(10),'ChoDuyet',DATE '2025-03-30');
    DBMS_OUTPUT.PUT_LINE('>> ThamGia CD8-10 (active): OK');
    -- 9. GIAY CHUNG NHAN cho 7 chien dich da ket thuc
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(1));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(2));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(3));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(4));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(5));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(6));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(7));
    DBMS_OUTPUT.PUT_LINE('>> GiayChungNhan: OK');
    -- 10. QUYEN GOP TIEN
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(1),v_cd_ids(1),500000,'ChuyenKhoan',DATE '2024-01-12');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(2),v_cd_ids(1),300000,'TienMat',DATE '2024-01-13');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(3),v_cd_ids(1),200000,'ChuyenKhoan',DATE '2024-01-13');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_bdh(1),v_cd_ids(1),1000000,'ChuyenKhoan',DATE '2024-01-10');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(5),v_cd_ids(2),2000000,'ChuyenKhoan',DATE '2024-06-20');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(6),v_cd_ids(2),1500000,'ChuyenKhoan',DATE '2024-06-21');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(7),v_cd_ids(2),1000000,'TienMat',DATE '2024-06-22');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_bdh(2),v_cd_ids(2),5000000,'ChuyenKhoan',DATE '2024-06-20');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_admin,v_cd_ids(2),10000000,'ChuyenKhoan',DATE '2024-06-20');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(9),v_cd_ids(3),500000,'ChuyenKhoan',DATE '2024-06-15');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(10),v_cd_ids(3),500000,'ChuyenKhoan',DATE '2024-06-16');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(16),v_cd_ids(6),1000000,'ChuyenKhoan',DATE '2024-10-25');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(17),v_cd_ids(6),800000,'TienMat',DATE '2024-10-26');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(20),v_cd_ids(7),2000000,'ChuyenKhoan',DATE '2024-10-18');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(21),v_cd_ids(7),1500000,'ChuyenKhoan',DATE '2024-10-18');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(22),v_cd_ids(7),1000000,'TienMat',DATE '2024-10-19');
    INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_admin,v_cd_ids(7),50000000,'ChuyenKhoan',DATE '2024-10-18');
    DBMS_OUTPUT.PUT_LINE('>> QuyenGopTien: OK');
    -- 11. TAI TRO (SPONSOR) - cot: MaDoiTac, MaChienDich, LoaiTaiTro, GiaTriTaiTro, NgayTaiTro
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(1),v_cd_ids(1),N'Tai tro vat chat',5000000,DATE '2024-01-10');
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(2),v_cd_ids(2),N'Tai tro tai chinh',50000000,DATE '2024-06-20');
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(3),v_cd_ids(2),N'Tai tro nhu yeu pham',20000000,DATE '2024-06-22');
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(1),v_cd_ids(3),N'Tai tro su kien',10000000,DATE '2024-06-15');
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(2),v_cd_ids(7),N'Tai tro khan cap',100000000,DATE '2024-10-18');
    INSERT INTO TaiTro(MaDoiTac,MaChienDich,LoaiTaiTro,GiaTriTaiTro,NgayTaiTro) VALUES(v_dt_ids(3),v_cd_ids(8),N'Tai tro nhu yeu pham',5000000,DATE '2025-01-15');
    DBMS_OUTPUT.PUT_LINE('>> TaiTro: OK');
    -- 12. CHI TIEU
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(1),N'In bang ron & poster',2000000,DATE '2024-01-14',N'Truyen thong');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(1),N'Mua qua tang & banh keo tet',5000000,DATE '2024-01-15',N'Qua tang');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(2),N'Vu khi va dung cu lao dong',15000000,DATE '2024-07-01',N'Trang thiet bi');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(2),N'Tien di chuyen xe may & xe tai',20000000,DATE '2024-07-01',N'Di chuyen');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(2),N'An uong hang ngay cho TNV',30000000,DATE '2024-07-01',N'An uong');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(3),N'Nuoc uong dong chai & khan lanh',8000000,DATE '2024-06-25',N'Phat cho thi sinh');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(3),N'Com hop cho tinh nguyen vien',5000000,DATE '2024-06-25',N'An uong TNV');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(6),N'Thu mua ao am & quan tet',30000000,DATE '2024-11-05',N'Hang hoa phat tang');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(6),N'Cuoc van chuyen ra Ha Giang',8000000,DATE '2024-12-01',N'Van chuyen');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(7),N'Luong thuc thuc pham cuu tro',150000000,DATE '2024-10-20',N'Hang cuu tro');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(7),N'Vat lieu xay dung sua nha',200000000,DATE '2024-10-25',N'Phuc hoi nha o');
    INSERT INTO ChiTieu(MaChienDich,TenKhoanChi,SoTienChi,NgayChi,MucDich) VALUES(v_cd_ids(7),N'Thue xe tai & di chuyen',50000000,DATE '2024-10-20',N'Di chuyen');
    DBMS_OUTPUT.PUT_LINE('>> ChiTieu: OK');
    -- 13. KHO VAT PHAM (KhoChienDich) qua SP_NHAPKHO / SP_XUATKHO
    -- CD1: Ao + Non
    SP_NHAPKHO_VATPHAM(v_cd_ids(1), v_loai_ids(1), 80);
    SP_NHAPKHO_VATPHAM(v_cd_ids(1), v_loai_ids(2), 80);
    SP_XUATKHO_VATPHAM(v_cd_ids(1), v_loai_ids(1), 75, N'Sinh vien KTX Khu A');
    SP_XUATKHO_VATPHAM(v_cd_ids(1), v_loai_ids(2), 78, N'Sinh vien KTX Khu A');
    -- CD2: Ao + Nuoc + Sua
    SP_NHAPKHO_VATPHAM(v_cd_ids(2), v_loai_ids(1), 120);
    SP_NHAPKHO_VATPHAM(v_cd_ids(2), v_loai_ids(3), 50);
    SP_NHAPKHO_VATPHAM(v_cd_ids(2), v_loai_ids(4), 30);
    SP_XUATKHO_VATPHAM(v_cd_ids(2), v_loai_ids(1), 118, N'TNV MHX 2024 Ben Tre');
    SP_XUATKHO_VATPHAM(v_cd_ids(2), v_loai_ids(3), 48, N'TNV MHX 2024 Ben Tre');
    SP_XUATKHO_VATPHAM(v_cd_ids(2), v_loai_ids(4), 28, N'Hoc sinh Ben Tre');
    -- CD3: Nuoc
    SP_NHAPKHO_VATPHAM(v_cd_ids(3), v_loai_ids(3), 100);
    SP_XUATKHO_VATPHAM(v_cd_ids(3), v_loai_ids(3), 95, N'Thi sinh cum thi DHQG-HCM');
    -- CD5: Non
    SP_NHAPKHO_VATPHAM(v_cd_ids(5), v_loai_ids(2), 50);
    SP_XUATKHO_VATPHAM(v_cd_ids(5), v_loai_ids(2), 48, N'TNV Hien Mau 2024');
    -- CD6: Ao am
    SP_NHAPKHO_VATPHAM(v_cd_ids(6), v_loai_ids(5), 500);
    SP_XUATKHO_VATPHAM(v_cd_ids(6), v_loai_ids(5), 490, N'Dong bao Ha Giang');
    -- CD7: Nuoc + Sua
    SP_NHAPKHO_VATPHAM(v_cd_ids(7), v_loai_ids(3), 200);
    SP_NHAPKHO_VATPHAM(v_cd_ids(7), v_loai_ids(4), 100);
    SP_XUATKHO_VATPHAM(v_cd_ids(7), v_loai_ids(3), 195, N'Ba con mien Trung');
    SP_XUATKHO_VATPHAM(v_cd_ids(7), v_loai_ids(4), 98, N'Ba con mien Trung');
    -- CD8 (dang hoat dong): Ao + Non da nhap, chua xuat
    SP_NHAPKHO_VATPHAM(v_cd_ids(8), v_loai_ids(1), 100);
    SP_NHAPKHO_VATPHAM(v_cd_ids(8), v_loai_ids(2), 100);
    DBMS_OUTPUT.PUT_LINE('>> KhoChienDich: OK');
    -- 14. THANH TOAN - lien ket voi QuyenGopTien qua MaQuyenGop
    -- ThanhToan chi co: MaQuyenGop, TrangThaiThanhToan, MaGiaoDichNganHang
    -- Insert QuyenGop truoc, lay MaQuyenGop, roi tao ThanhToan tuong ung
    DECLARE v_ma_qg VARCHAR2(10);
    BEGIN
        INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(1),v_cd_ids(1),50000,'ChuyenKhoan',DATE '2024-01-15') RETURNING MaQuyenGop INTO v_ma_qg;
        INSERT INTO ThanhToan(MaQuyenGop,TrangThaiThanhToan,MaGiaoDichNganHang) VALUES(v_ma_qg,'ThanhCong','TXN-XTN2024-001');
        INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(2),v_cd_ids(1),50000,'TienMat',DATE '2024-01-15') RETURNING MaQuyenGop INTO v_ma_qg;
        INSERT INTO ThanhToan(MaQuyenGop,TrangThaiThanhToan) VALUES(v_ma_qg,'ThanhCong');
        INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(3),v_cd_ids(1),50000,'ChuyenKhoan',DATE '2024-01-15') RETURNING MaQuyenGop INTO v_ma_qg;
        INSERT INTO ThanhToan(MaQuyenGop,TrangThaiThanhToan,MaGiaoDichNganHang) VALUES(v_ma_qg,'ThanhCong','TXN-XTN2024-003');
        INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(24),v_cd_ids(8),50000,'ChuyenKhoan',DATE '2025-01-20') RETURNING MaQuyenGop INTO v_ma_qg;
        INSERT INTO ThanhToan(MaQuyenGop,TrangThaiThanhToan,MaGiaoDichNganHang) VALUES(v_ma_qg,'ThanhCong','TXN-XTN2025-001');
        INSERT INTO QuyenGopTien(MaTaiKhoan,MaChienDich,SoTien,PhuongThuc,NgayGiaoDich) VALUES(v_tk_tnv(25),v_cd_ids(8),50000,'ChuyenKhoan',DATE '2025-01-20') RETURNING MaQuyenGop INTO v_ma_qg;
        INSERT INTO ThanhToan(MaQuyenGop,TrangThaiThanhToan) VALUES(v_ma_qg,'DangXuLy');
    END;
    DBMS_OUTPUT.PUT_LINE('>> ThanhToan: OK');
    -- 15. BINH LUAN - link qua MaTinTuc (khong phai MaChienDich)
    INSERT INTO BinhLuan(MaTinTuc,MaTaiKhoan,NoiDung) VALUES(v_tn_ids(1),v_tk_tnv(1),N'Chuong trinh rat y nghia, minh se tham gia them lan toi!');
    INSERT INTO BinhLuan(MaTinTuc,MaTaiKhoan,NoiDung) VALUES(v_tn_ids(2),v_tk_tnv(5),N'MHX 2024 la hanh trinh tuyet voi nhat trong cuoc doi sinh vien cua minh!');
    INSERT INTO BinhLuan(MaTinTuc,MaTaiKhoan,NoiDung) VALUES(v_tn_ids(3),v_tk_tnv(9),N'Rat vui vi da gop phan giup cac ban thi sinh tu tin hon vao ngay thi.');
    INSERT INTO BinhLuan(MaTinTuc,MaTaiKhoan,NoiDung) VALUES(v_tn_ids(7),v_tk_tnv(20),N'Mot trong nhung hoat dong tinh nguyen co y nghia nhat minh tung tham gia. Cam on ban to chuc!');
    INSERT INTO BinhLuan(MaTinTuc,MaTaiKhoan,NoiDung) VALUES(v_tn_ids(8),v_tk_tnv(24),N'Dang cho ngay khai mac! Ban to chuc lam rat tot.');
    DBMS_OUTPUT.PUT_LINE('>> BinhLuan: OK');
    -- 16. THEO DOI
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(27),v_cd_ids(8));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(28),v_cd_ids(8));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(37),v_cd_ids(8));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(38),v_cd_ids(8));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(31),v_cd_ids(9));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(39),v_cd_ids(9));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(35),v_cd_ids(10));
    INSERT INTO TheoDoi(MaTaiKhoan,MaChienDich) VALUES(v_tk_tnv(40),v_cd_ids(10));
    DBMS_OUTPUT.PUT_LINE('>> TheoDoi: OK');
    -- 17. THONG BAO
    INSERT INTO ThongBao(MaTaiKhoan,TieuDe,NoiDung) VALUES(v_tk_admin,N'He thong duoc nang cap len phien ban 2.0',N'Chao mung toan the TNV! He thong quan ly hoat dong tinh nguyen da duoc nang cap len phien ban 2.0 voi nhieu tinh nang moi.');
    INSERT INTO ThongBao(MaTaiKhoan,TieuDe,NoiDung) VALUES(v_tk_bdh(8),N'XTN 2025: Lich hop TNV da duyet ngay 19/01',N'Cac tinh nguyen vien da duoc duyet tham gia XTN 2025 vui long co mat hop nham ngay 19/01/2025 luc 14h tai Hoi truong A.');
    INSERT INTO ThongBao(MaTaiKhoan,TieuDe,NoiDung) VALUES(v_tk_bdh(9),N'TSMT 2025: Mo dang ky tu 01/06/2025',N'Chinh thuc mo dang ky tinh nguyen vien cho Tiep Suc Mua Thi 2025. Han chot: 20/06/2025.');
    DBMS_OUTPUT.PUT_LINE('>> ThongBao: OK');
    -- Re-enable triggers
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_CHANXOA_CHIENDICH ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_THOIGIAN ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_TRUNG_LICH ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY ENABLE';
    DBMS_OUTPUT.PUT_LINE('>> Enabled triggers OK');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('>> SEED DATA DEMO HOAN THANH THANH CONG!');
    DBMS_OUTPUT.PUT_LINE('>> 1 Admin | 10 BDH | 40 TNV | 10 ChienDich');
    DBMS_OUTPUT.PUT_LINE('>> 7 DaKetThuc | 3 DangHoatDong');
    DBMS_OUTPUT.PUT_LINE('====================================================');
EXCEPTION
    WHEN OTHERS THEN
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_CHANXOA_CHIENDICH ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_THOIGIAN ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_TRUNG_LICH ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY ENABLE';
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('>> LOI: ' || SQLERRM);
        RAISE;
END;
/


