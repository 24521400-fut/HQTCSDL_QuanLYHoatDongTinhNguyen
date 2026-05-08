-- ============================================================
-- FILE: 01_sequences.sql
-- MUC DICH: Tao tat ca SEQUENCES cho he thong quan ly hoat dong tinh nguyen
-- CHAY TRUOC: Tat ca cac file khac
-- ============================================================

-- Xoa sequence cu neu ton tai (bo qua loi neu khong ton tai)
BEGIN
    FOR s IN (SELECT sequence_name FROM user_sequences 
              WHERE sequence_name IN (
                'S_TAIKHOAN_ID','S_HOSO_ID','S_NHATKY_ID','S_CHIENDICH_ID',
                'S_DUYET_ID','S_TINTUC_ID','S_BINHLUAN_ID','S_THAMGIA_ID',
                'S_CONGVIEC_ID','S_PHANCONG_ID','S_DIEMDANH_ID',
                'S_MINHCHUNGTNV_ID','S_MINHCHUNGCT_ID','S_GIAYCHUNGNHAN_ID',
                'S_QUYENGOP_ID','S_THANHTOAN_ID','S_CHITIEU_ID',
                'S_DOITAC_ID','S_TAITRO_ID','S_LOAIVP_ID',
                'S_PHIEUQGVP_ID','S_PHIEUXUAT_ID','S_THONGBAO_ID','S_THAMSO_ID'
              )) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/

-- ============================================================
-- SEQUENCES CHINH
-- ============================================================

CREATE SEQUENCE s_taikhoan_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_hoso_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_nhatky_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_chiendich_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_duyet_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_tintuc_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_binhluan_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_thamgia_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_congviec_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_phancong_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_diemdanh_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_minhchungtnv_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_minhchungct_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_giaychungnhan_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_quyengop_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_thanhtoan_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_chitieu_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_doitac_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_taitro_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_loaivp_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_phieuqgvp_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_phieuxuat_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_thongbao_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

CREATE SEQUENCE s_thamso_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

COMMIT;
PROMPT >> 01_sequences.sql: Da tao xong tat ca SEQUENCES.
-- ============================================================
-- FILE: 02_tables.sql
-- MUC DICH: Tao tat ca BANG DU LIEU cho he thong quan ly hoat dong tinh nguyen
-- CHAY SAU: 01_sequences.sql
-- ============================================================

-- Xoa cac bang cu theo thu tu nguoc (tranh vi pham FK)
BEGIN
    FOR t IN (SELECT table_name FROM user_tables 
              WHERE UPPER(table_name) IN (
                UPPER('ChiTietXuatVP'), UPPER('PhieuXuatVatPham'),
                UPPER('ChiTietQuyenGopVP'), UPPER('PhieuQuyenGopVP'),
                UPPER('TheoDoi'), UPPER('ThongBao'),
                UPPER('ThamSo'), UPPER('ChiTieu'), UPPER('MinhChungChiTieu'),
                UPPER('ThanhToan'), UPPER('QuyenGopTien'),
                UPPER('GiayChungNhan'), UPPER('MinhChungTNV'),
                UPPER('DiemDanh'), UPPER('PhanCong'), UPPER('CongViec'),
                UPPER('ThamGiaTNV'), UPPER('BinhLuan'), UPPER('TinTuc'),
                UPPER('DuyetChienDich'), UPPER('BanDieuHanh'), UPPER('ChienDich'),
                UPPER('TaiTro'), UPPER('DoiTac'), UPPER('LoaiVatPham'),
                UPPER('NhatKyHeThong'), UPPER('HoSoSinhVien'), UPPER('TaiKhoan')
              )) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS PURGE';
        EXCEPTION
            WHEN OTHERS THEN NULL;
        END;
    END LOOP;
END;
/

-- ============================================================
-- 1. TAIKHOAN
-- ============================================================
CREATE TABLE TaiKhoan (
    MaTaiKhoan  VARCHAR2(10)          NOT NULL,
    TenDangNhap VARCHAR2(50)    NOT NULL,
    MatKhau     VARCHAR2(255)   NOT NULL,
    Email       VARCHAR2(100)   NOT NULL,
    VaiTro      VARCHAR2(20)    NOT NULL,
    TrangThai   VARCHAR2(20)    DEFAULT 'ChoXacNhan' NOT NULL,
    NgayTao     DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_TaiKhoan      PRIMARY KEY (MaTaiKhoan),
    CONSTRAINT UQ_TK_TenDN      UNIQUE (TenDangNhap),
    CONSTRAINT UQ_TK_Email      UNIQUE (Email),
    CONSTRAINT CHK_TK_VaiTro    CHECK (VaiTro IN ('QuanTriVien','BanQuanLy','BanDieuHanh','TinhNguyenVien')),
    CONSTRAINT CHK_TK_TrangThai CHECK (TrangThai IN ('HoatDong','Khoa','ChoXacNhan'))
);

-- ============================================================
-- 2. HOSOSINHVIEN
-- ============================================================
CREATE TABLE HoSoSinhVien (
    MaHoSo      VARCHAR2(10)          NOT NULL,
    MaTaiKhoan  VARCHAR2(10)          NOT NULL,
    HoTen       NVARCHAR2(100)  NOT NULL,
    MSSV        VARCHAR2(20)    NOT NULL,
    NgaySinh    DATE            NOT NULL,
    GioiTinh    NVARCHAR2(10)   NOT NULL,
    Khoa        NVARCHAR2(100)  NOT NULL,
    Lop         VARCHAR2(20)    NOT NULL,
    SoDienThoai VARCHAR2(15)    NOT NULL,
    TongDiem    NUMBER(5,1)     DEFAULT 0,
    DiaChi      NVARCHAR2(200)  NOT NULL,
    CONSTRAINT PK_HoSo          PRIMARY KEY (MaHoSo),
    CONSTRAINT UQ_HoSo_TK       UNIQUE (MaTaiKhoan),
    CONSTRAINT UQ_HoSo_MSSV     UNIQUE (MSSV),
    CONSTRAINT FK_HoSo_TK       FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT CHK_HoSo_GT      CHECK (GioiTinh IN (N'Nam', N'Nu', N'Khac'))
);

-- ============================================================
-- 3. NHATKYHETONG
-- ============================================================
CREATE TABLE NhatKyHeThong (
    MaNhatKy    VARCHAR2(10)          NOT NULL,
    MaTaiKhoan  VARCHAR2(10)          NOT NULL,
    HanhDong    NVARCHAR2(255)  NOT NULL,
    ThoiGian    DATE            DEFAULT SYSDATE NOT NULL,
    ChiTiet     CLOB,
    CONSTRAINT PK_NhatKy        PRIMARY KEY (MaNhatKy),
    CONSTRAINT FK_NhatKy_TK     FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE
);

-- ============================================================
-- 4. DOITAC
-- ============================================================
CREATE TABLE DoiTac (
    MaDoiTac        VARCHAR2(10)          NOT NULL,
    TenDoiTac       NVARCHAR2(200)  NOT NULL,
    LinhVuc         NVARCHAR2(100),
    SoDienThoai     VARCHAR2(15),
    Email           VARCHAR2(100),
    DiaChi          NVARCHAR2(255),
    NguoiDaiDien    NVARCHAR2(100),
    CONSTRAINT PK_DoiTac        PRIMARY KEY (MaDoiTac),
    CONSTRAINT UQ_DT_Email      UNIQUE (Email)
);

-- ============================================================
-- 5. LOAIVATPHAM
-- ============================================================
CREATE TABLE LoaiVatPham (
    MaLoai      VARCHAR2(10)          NOT NULL,
    TenLoai     NVARCHAR2(100)  NOT NULL,
    DonViTinh   NVARCHAR2(50)   NOT NULL,
    SoLuongTon  NUMBER          DEFAULT 0 NOT NULL,
    MoTa        NVARCHAR2(500),
    CONSTRAINT PK_LoaiVatPham   PRIMARY KEY (MaLoai),
    CONSTRAINT UQ_LVP_TenLoai   UNIQUE (TenLoai),
    CONSTRAINT CHK_LVP_SL       CHECK (SoLuongTon >= 0)
);

-- ============================================================
-- 6. THAMSO
-- ============================================================
CREATE TABLE ThamSo (
    MaThamSo    VARCHAR2(10)          NOT NULL,
    TenThamSo   VARCHAR2(100)   NOT NULL,
    GiaTri      VARCHAR2(500)   NOT NULL,
    GhiChu      NVARCHAR2(500),
    NgayCapNhat DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_ThamSo        PRIMARY KEY (MaThamSo),
    CONSTRAINT UQ_TS_Ten        UNIQUE (TenThamSo)
);

-- ============================================================
-- 7. CHIENDICH
-- ============================================================
CREATE TABLE ChienDich (
    MaChienDich     VARCHAR2(10)          NOT NULL,
    TenChienDich    NVARCHAR2(255)  NOT NULL,
    MoTa            CLOB,
    NgayBatDau      DATE            NOT NULL,
    NgayKetThuc     DATE,
    DiaDiem         NVARCHAR2(200),
    SoLuongTNVToiDa NUMBER          DEFAULT 100 NOT NULL,
    SoLuongHienTai  NUMBER          DEFAULT 0,
    DiemThuong      NUMBER(3,1)     DEFAULT 0,
    MucTieuTien     NUMBER(18,2)    DEFAULT 0,
    GioToiThieuCN   NUMBER,
    TrangThai       VARCHAR2(20)    DEFAULT 'ChoDuyet' NOT NULL,
    MaNguoiTao      VARCHAR2(10)          NOT NULL,
    CONSTRAINT PK_ChienDich     PRIMARY KEY (MaChienDich),
    CONSTRAINT FK_CD_NguoiTao   FOREIGN KEY (MaNguoiTao) REFERENCES TaiKhoan(MaTaiKhoan),
    CONSTRAINT CHK_CD_SoLuong   CHECK (SoLuongTNVToiDa > 0),
    CONSTRAINT CHK_CD_MucTieu   CHECK (MucTieuTien >= 0),
    CONSTRAINT CHK_CD_TrangThai CHECK (TrangThai IN ('ChoDuyet','DangHoatDong','DaTamDung','DaKetThuc','BiTuChoi','Huy')),
    CONSTRAINT CHK_CD_Ngay      CHECK (NgayKetThuc IS NULL OR NgayKetThuc >= NgayBatDau)
);

-- ============================================================
-- 8. BANDIEUHANH
-- ============================================================
CREATE TABLE BanDieuHanh (
    MaTaiKhoan  VARCHAR2(10)          NOT NULL,
    MaChienDich VARCHAR2(10)          NOT NULL,
    NgayPhanCong DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_BanDieuHanh   PRIMARY KEY (MaTaiKhoan),
    CONSTRAINT FK_BDH_TK        FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT FK_BDH_CD        FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT UQ_BDH_CD        UNIQUE (MaChienDich)
);

-- ============================================================
-- 9. DUYETCHIENDICH
-- ============================================================
CREATE TABLE DuyetChienDich (
    MaDuyet         VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    MaNguoiDuyet    VARCHAR2(10)          NOT NULL,
    TrangThai       VARCHAR2(20)    DEFAULT 'ChoDuyet' NOT NULL,
    NgayDuyet       DATE,
    GhiChu          NVARCHAR2(500),
    CONSTRAINT PK_DuyetCD       PRIMARY KEY (MaDuyet),
    CONSTRAINT FK_Duyet_CD      FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT FK_Duyet_ND      FOREIGN KEY (MaNguoiDuyet) REFERENCES TaiKhoan(MaTaiKhoan),
    CONSTRAINT CHK_Duyet_TS    CHECK (TrangThai IN ('ChoDuyet','DaDuyet','TuChoi','HoanThanh','Huy'))
);

-- ============================================================
-- 10. TINTUC
-- ============================================================
CREATE TABLE TinTuc (
    MaTinTuc        VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    TieuDe          NVARCHAR2(500)  NOT NULL,
    NoiDung         CLOB            NOT NULL,
    HinhAnh         VARCHAR2(500),
    NgayDang        DATE            DEFAULT SYSDATE NOT NULL,
    MaNguoiDang     VARCHAR2(10)          NOT NULL,
    CONSTRAINT PK_TinTuc        PRIMARY KEY (MaTinTuc),
    CONSTRAINT FK_TT_CD         FOREIGN KEY (MaChienDich)  REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT FK_TT_TacGia     FOREIGN KEY (MaNguoiDang)  REFERENCES TaiKhoan(MaTaiKhoan)
);

-- ============================================================
-- 11. BINHLUAN
-- ============================================================
CREATE TABLE BinhLuan (
    MaBinhLuan      VARCHAR2(10)          NOT NULL,
    MaTinTuc        VARCHAR2(10)          NOT NULL,
    MaTaiKhoan      VARCHAR2(10)          NOT NULL,
    NoiDung         CLOB            NOT NULL,
    ThoiGian        DATE            DEFAULT SYSDATE NOT NULL,
    TrangThai       VARCHAR2(20)    DEFAULT 'HienThi' NOT NULL,
    CONSTRAINT PK_BinhLuan      PRIMARY KEY (MaBinhLuan),
    CONSTRAINT FK_BL_TinTuc     FOREIGN KEY (MaTinTuc)    REFERENCES TinTuc(MaTinTuc) ON DELETE CASCADE,
    CONSTRAINT FK_BL_TK         FOREIGN KEY (MaTaiKhoan)  REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT CHK_BL_TS        CHECK (TrangThai IN ('HienThi','AnDi','ChoKiemDuyet'))
);

-- ============================================================
-- 12. THAMGIATNV
-- ============================================================
CREATE TABLE ThamGiaTNV (
    MaThamGia       VARCHAR2(10)          NOT NULL,
    MaTaiKhoan      VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    NgayDangKy      DATE            DEFAULT SYSDATE NOT NULL,
    TrangThaiDuyet  VARCHAR2(20)    DEFAULT 'ChoDuyet' NOT NULL,
    TrangThai       VARCHAR2(20),
    DiemDanhGia     NUMBER(3,1),
    CONSTRAINT PK_ThamGiaTNV    PRIMARY KEY (MaThamGia),
    CONSTRAINT UQ_TG_TK_CD      UNIQUE (MaTaiKhoan, MaChienDich),
    CONSTRAINT FK_TG_TK         FOREIGN KEY (MaTaiKhoan)  REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT FK_TG_CD         FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT CHK_TG_TS        CHECK (TrangThaiDuyet IN ('ChoDuyet','DaDuyet','TuChoi','HoanThanh','Huy')),
    CONSTRAINT CHK_TG_Diem      CHECK (DiemDanhGia IS NULL OR (DiemDanhGia >= 0 AND DiemDanhGia <= 10))
);

-- ============================================================
-- 13. CONGVIEC
-- ============================================================
CREATE TABLE CongViec (
    MaCongViec      VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    TenCongViec     NVARCHAR2(255)  NOT NULL,
    MoTa            CLOB,
    SoLuongTNVCan   NUMBER          DEFAULT 1 NOT NULL,
    ThoiGianBatDau  DATE,
    CONSTRAINT PK_CongViec      PRIMARY KEY (MaCongViec),
    CONSTRAINT FK_CV_CD         FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT CHK_CV_SL        CHECK (SoLuongTNVCan > 0)
);

-- ============================================================
-- 14. PHANCONG
-- ============================================================
CREATE TABLE PhanCong (
    MaPhanCong      VARCHAR2(10)          NOT NULL,
    MaThamGia       VARCHAR2(10)          NOT NULL,
    MaCongViec      VARCHAR2(10)          NOT NULL,
    VaiTroCuThe     NVARCHAR2(255),
    NgayGiao        DATE,
    TrangThai       VARCHAR2(20)    DEFAULT 'ChuaBatDau' NOT NULL,
    CONSTRAINT PK_PhanCong      PRIMARY KEY (MaPhanCong),
    CONSTRAINT UQ_PC_TG_CV      UNIQUE (MaThamGia, MaCongViec),
    CONSTRAINT FK_PC_ThamGia    FOREIGN KEY (MaThamGia)  REFERENCES ThamGiaTNV(MaThamGia) ON DELETE CASCADE,
    CONSTRAINT FK_PC_CongViec   FOREIGN KEY (MaCongViec) REFERENCES CongViec(MaCongViec) ON DELETE CASCADE,
    CONSTRAINT CHK_PC_TS        CHECK (TrangThai IN ('ChuaBatDau','DangThucHien','HoanThanh','HuyBo'))
);

-- ============================================================
-- 15. DIEMDANH
-- ============================================================
CREATE TABLE DiemDanh (
    MaDiemDanh      VARCHAR2(10)          NOT NULL,
    MaThamGia       VARCHAR2(10)          NOT NULL,
    NgayDiemDanh    DATE            NOT NULL,
    TrangThai       VARCHAR2(20)    DEFAULT 'CoMat' NOT NULL,
    SoGioGhiNhan    NUMBER(4,1)     DEFAULT 0,
    CONSTRAINT PK_DiemDanh      PRIMARY KEY (MaDiemDanh),
    CONSTRAINT UQ_DD_TG_Ngay    UNIQUE (MaThamGia, NgayDiemDanh),
    CONSTRAINT FK_DD_ThamGia    FOREIGN KEY (MaThamGia) REFERENCES ThamGiaTNV(MaThamGia) ON DELETE CASCADE,
    CONSTRAINT CHK_DD_TS        CHECK (TrangThai IN ('CoMat','VangMat','CoPhep')),
    CONSTRAINT CHK_DD_SoGio     CHECK (SoGioGhiNhan >= 0)
);

-- ============================================================
-- 16. MINHCHUNGTNV
-- ============================================================
CREATE TABLE MinhChungTNV (
    MaMinhChung     VARCHAR2(10)          NOT NULL,
    MaThamGia       VARCHAR2(10)          NOT NULL,
    HinhAnh_URL     VARCHAR2(500)   NOT NULL,
    LoaiMinhChung   NVARCHAR2(100)  NOT NULL,
    NgayCapNhat     DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_MinhChungTNV  PRIMARY KEY (MaMinhChung),
    CONSTRAINT FK_MCTNV_TG      FOREIGN KEY (MaThamGia) REFERENCES ThamGiaTNV(MaThamGia) ON DELETE CASCADE
);

-- ============================================================
-- 17. GIAYCHUNGNHAN
-- ============================================================
CREATE TABLE GiayChungNhan (
    MaChungNhan     VARCHAR2(10)          NOT NULL,
    MaThamGia       VARCHAR2(10)          NOT NULL,
    NgayCap         DATE            NOT NULL,
    LinkFile_URL    VARCHAR2(500),
    XepLoai         VARCHAR2(20)    NOT NULL,
    CONSTRAINT PK_GiayChungNhan PRIMARY KEY (MaChungNhan),
    CONSTRAINT UQ_GCN_ThamGia   UNIQUE (MaThamGia),
    CONSTRAINT FK_GCN_ThamGia   FOREIGN KEY (MaThamGia) REFERENCES ThamGiaTNV(MaThamGia) ON DELETE CASCADE,
    CONSTRAINT CHK_GCN_XepLoai  CHECK (XepLoai IN ('XuatSac','Tot','Kha','TrungBinh'))
);

-- ============================================================
-- 18. QUYENGOPTIEN
-- ============================================================
CREATE TABLE QuyenGopTien (
    MaQuyenGop          VARCHAR2(10)          NOT NULL,
    MaTaiKhoan          VARCHAR2(10)          NOT NULL,
    MaChienDich         VARCHAR2(10)          NOT NULL,
    SoTien              NUMBER(18,2)    NOT NULL,
    NgayGiaoDich        DATE            DEFAULT SYSDATE NOT NULL,
    PhuongThuc          VARCHAR2(20)    NOT NULL,
    LoiNhan             NVARCHAR2(500),
    CONSTRAINT PK_QuyenGopTien  PRIMARY KEY (MaQuyenGop),
    CONSTRAINT FK_QGT_TK        FOREIGN KEY (MaTaiKhoan)  REFERENCES TaiKhoan(MaTaiKhoan),
    CONSTRAINT FK_QGT_CD        FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich),
    CONSTRAINT CHK_QGT_SoTien   CHECK (SoTien > 0),
    CONSTRAINT CHK_QGT_PT       CHECK (PhuongThuc IN ('ChuyenKhoan','TienMat','MoMo','VNPay','ZaloPay'))
);

-- ============================================================
-- 19. THANHTOAN
-- ============================================================
CREATE TABLE ThanhToan (
    MaThanhToan         VARCHAR2(10)          NOT NULL,
    MaQuyenGop          VARCHAR2(10)          NOT NULL,
    TrangThaiThanhToan  VARCHAR2(20)    DEFAULT 'DangXuLy' NOT NULL,
    MaGiaoDichNganHang  VARCHAR2(100),
    NgayThanhToan       DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_ThanhToan     PRIMARY KEY (MaThanhToan),
    CONSTRAINT UQ_TT_QuyenGop   UNIQUE (MaQuyenGop),
    CONSTRAINT UQ_TT_MaGD       UNIQUE (MaGiaoDichNganHang),
    CONSTRAINT FK_TT_QuyenGop   FOREIGN KEY (MaQuyenGop) REFERENCES QuyenGopTien(MaQuyenGop) ON DELETE CASCADE,
    CONSTRAINT CHK_TT_TS        CHECK (TrangThaiThanhToan IN ('DangXuLy','ThanhCong','ThatBai','HoanTien'))
);

-- ============================================================
-- 20. MINHCHUNGCHITIEU
-- ============================================================
CREATE TABLE MinhChungChiTieu (
    MaMinhChung     VARCHAR2(10)          NOT NULL,
    HinhAnh_URL     VARCHAR2(500)   NOT NULL,
    LoaiMinhChung   NVARCHAR2(100)  NOT NULL,
    NgayCapNhat     DATE            DEFAULT SYSDATE NOT NULL,
    GhiChu          NVARCHAR2(500),
    CONSTRAINT PK_MinhChungCT   PRIMARY KEY (MaMinhChung)
);

-- ============================================================
-- 21. CHITIEU
-- ============================================================
CREATE TABLE ChiTieu (
    MaChiTieu       VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    TenKhoanChi     NVARCHAR2(200)  NOT NULL,
    SoTienChi       NUMBER(18,2)    NOT NULL,
    NgayChi         DATE            NOT NULL,
    MucDich         NVARCHAR2(500)  NOT NULL,
    MaMinhChung     VARCHAR2(10),
    MaNguoiChi      VARCHAR2(10),
    CONSTRAINT PK_ChiTieu       PRIMARY KEY (MaChiTieu),
    CONSTRAINT FK_CT_CD         FOREIGN KEY (MaChienDich)  REFERENCES ChienDich(MaChienDich),
    CONSTRAINT FK_CT_MinhChung  FOREIGN KEY (MaMinhChung)  REFERENCES MinhChungChiTieu(MaMinhChung),
    CONSTRAINT FK_CT_NguoiChi   FOREIGN KEY (MaNguoiChi)   REFERENCES TaiKhoan(MaTaiKhoan),
    CONSTRAINT CHK_CT_SoTien    CHECK (SoTienChi > 0)
);

-- ============================================================
-- 22. TAITRO
-- ============================================================
CREATE TABLE TaiTro (
    MaTaiTro        VARCHAR2(10)          NOT NULL,
    MaDoiTac        VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    LoaiTaiTro      NVARCHAR2(50),
    GiaTriTaiTro    NUMBER(18,2)    NOT NULL,
    NgayTaiTro      DATE            NOT NULL,
    CONSTRAINT PK_TaiTro        PRIMARY KEY (MaTaiTro),
    CONSTRAINT FK_TaiTro_DT     FOREIGN KEY (MaDoiTac)    REFERENCES DoiTac(MaDoiTac),
    CONSTRAINT FK_TaiTro_CD     FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich),
    CONSTRAINT CHK_TaiTro_GT   CHECK (GiaTriTaiTro > 0)
);

-- ============================================================
-- 23. PHIEUQUYENGOPVP
-- ============================================================
CREATE TABLE PhieuQuyenGopVP (
    MaPhieuQG       VARCHAR2(10)          NOT NULL,
    MaTaiKhoan      VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    NgayTiepNhan    DATE            DEFAULT SYSDATE NOT NULL,
    NguoiNhan       NVARCHAR2(150)  NOT NULL,
    CONSTRAINT PK_PhieuQGVP     PRIMARY KEY (MaPhieuQG),
    CONSTRAINT FK_PQGVP_TK      FOREIGN KEY (MaTaiKhoan)  REFERENCES TaiKhoan(MaTaiKhoan),
    CONSTRAINT FK_PQGVP_CD      FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich)
);

-- ============================================================
-- 24. CHITIETQUYENGOPVP
-- ============================================================
CREATE TABLE ChiTietQuyenGopVP (
    MaPhieuQG       VARCHAR2(10)          NOT NULL,
    MaLoai          VARCHAR2(10)          NOT NULL,
    SoLuong         NUMBER          NOT NULL,
    TinhTrang       NVARCHAR2(100),
    CONSTRAINT PK_ChiTietQGVP   PRIMARY KEY (MaPhieuQG, MaLoai),
    CONSTRAINT FK_CTQGVP_Phieu  FOREIGN KEY (MaPhieuQG) REFERENCES PhieuQuyenGopVP(MaPhieuQG) ON DELETE CASCADE,
    CONSTRAINT FK_CTQGVP_Loai   FOREIGN KEY (MaLoai)    REFERENCES LoaiVatPham(MaLoai),
    CONSTRAINT CHK_CTQGVP_SL    CHECK (SoLuong > 0)
);

-- ============================================================
-- 25. PHIEUXUATVP
-- ============================================================
CREATE TABLE PhieuXuatVatPham (
    MaPhieuXuat     VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    NgayXuat        DATE            NOT NULL,
    NguoiXuat       NVARCHAR2(150)  NOT NULL,
    NguoiNhan       NVARCHAR2(150)  NOT NULL,
    CONSTRAINT PK_PhieuXuatVP   PRIMARY KEY (MaPhieuXuat),
    CONSTRAINT FK_PXVP_CD       FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich)
);

-- ============================================================
-- 26. CHITIETXUATVP
-- ============================================================
CREATE TABLE ChiTietXuatVP (
    MaPhieuXuat     VARCHAR2(10)          NOT NULL,
    MaLoai          VARCHAR2(10)          NOT NULL,
    SoLuong         NUMBER          NOT NULL,
    CONSTRAINT PK_ChiTietXuatVP PRIMARY KEY (MaPhieuXuat, MaLoai),
    CONSTRAINT FK_CTXVP_Phieu   FOREIGN KEY (MaPhieuXuat) REFERENCES PhieuXuatVatPham(MaPhieuXuat) ON DELETE CASCADE,
    CONSTRAINT FK_CTXVP_Loai    FOREIGN KEY (MaLoai)      REFERENCES LoaiVatPham(MaLoai),
    CONSTRAINT CHK_CTXVP_SL     CHECK (SoLuong > 0)
);

-- ============================================================
-- 27. THONGBAO
-- ============================================================
CREATE TABLE ThongBao (
    MaThongBao      VARCHAR2(10)          NOT NULL,
    MaTaiKhoan      VARCHAR2(10)          NOT NULL,
    TieuDe          NVARCHAR2(255)  NOT NULL,
    NoiDung         CLOB            NOT NULL,
    NgayGui         DATE            DEFAULT SYSDATE NOT NULL,
    TrangThai       VARCHAR2(20)    DEFAULT 'ChuaDoc' NOT NULL,
    CONSTRAINT PK_ThongBao      PRIMARY KEY (MaThongBao),
    CONSTRAINT FK_TB_TK         FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT CHK_TB_TS        CHECK (TrangThai IN ('ChuaDoc','DaDoc'))
);

-- ============================================================
-- 28. THEODOI
-- ============================================================
CREATE TABLE TheoDoi (
    MaTaiKhoan      VARCHAR2(10)          NOT NULL,
    MaChienDich     VARCHAR2(10)          NOT NULL,
    NgayTheoDoi     DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_TheoDoi       PRIMARY KEY (MaTaiKhoan, MaChienDich),
    CONSTRAINT FK_TD_TK         FOREIGN KEY (MaTaiKhoan)  REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
    CONSTRAINT FK_TD_CD         FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE
);

COMMIT;
PROMPT >> 02_tables.sql: Da tao xong tat ca BANG DU LIEU voi RANG BUOC.
-- ============================================================
-- FILE: 03_indexes.sql
-- MUC DICH: Tao tat ca INDEXES de toi uu hieu nang truy van
-- CHAY SAU: 02_tables.sql
-- ============================================================

-- Indexes cho TaiKhoan
CREATE INDEX IDX_TK_VaiTro          ON TaiKhoan(VaiTro);
CREATE INDEX IDX_TK_TrangThai        ON TaiKhoan(TrangThai);

-- Indexes cho HoSoSinhVien
CREATE INDEX IDX_HSSV_TK             ON HoSoSinhVien(MaTaiKhoan);
CREATE INDEX IDX_HSSV_SoDT           ON HoSoSinhVien(SoDienThoai);

-- Indexes cho NhatKyHeThong
CREATE INDEX IDX_NhatKy_TK           ON NhatKyHeThong(MaTaiKhoan);
CREATE INDEX IDX_NhatKy_ThoiGian     ON NhatKyHeThong(ThoiGian);

-- Indexes cho ChienDich
CREATE INDEX IDX_CD_TrangThai        ON ChienDich(TrangThai);
CREATE INDEX IDX_CD_NguoiTao         ON ChienDich(MaNguoiTao);
CREATE INDEX IDX_CD_NgayBD           ON ChienDich(NgayBatDau);

-- Indexes cho DuyetChienDich
CREATE INDEX IDX_Duyet_CD            ON DuyetChienDich(MaChienDich);
CREATE INDEX IDX_Duyet_ND            ON DuyetChienDich(MaNguoiDuyet);

-- Indexes cho TinTuc
CREATE INDEX IDX_TT_CD               ON TinTuc(MaChienDich);
CREATE INDEX IDX_TT_TacGia           ON TinTuc(MaNguoiDang);
CREATE INDEX IDX_TT_NgayDang         ON TinTuc(NgayDang);

-- Indexes cho BinhLuan
CREATE INDEX IDX_BL_TinTuc           ON BinhLuan(MaTinTuc);
CREATE INDEX IDX_BL_TK               ON BinhLuan(MaTaiKhoan);

-- Indexes cho ThamGiaTNV
CREATE INDEX IDX_TG_CD               ON ThamGiaTNV(MaChienDich);
CREATE INDEX IDX_TG_TK               ON ThamGiaTNV(MaTaiKhoan);
CREATE INDEX IDX_TG_TrangThai        ON ThamGiaTNV(TrangThaiDuyet);

-- Indexes cho CongViec
CREATE INDEX IDX_CV_CD               ON CongViec(MaChienDich);

-- Indexes cho PhanCong
CREATE INDEX IDX_PC_ThamGia          ON PhanCong(MaThamGia);
CREATE INDEX IDX_PC_CongViec         ON PhanCong(MaCongViec);

-- Indexes cho DiemDanh
CREATE INDEX IDX_DD_ThamGia          ON DiemDanh(MaThamGia);
CREATE INDEX IDX_DD_Ngay             ON DiemDanh(NgayDiemDanh);

-- Indexes cho MinhChungTNV
CREATE INDEX IDX_MCTNV_TG            ON MinhChungTNV(MaThamGia);

-- Indexes cho GiayChungNhan
CREATE INDEX IDX_GCN_TG              ON GiayChungNhan(MaThamGia);
CREATE INDEX IDX_GCN_NgayCap         ON GiayChungNhan(NgayCap);

-- Indexes cho QuyenGopTien
CREATE INDEX IDX_QGT_CD              ON QuyenGopTien(MaChienDich);
CREATE INDEX IDX_QGT_TK              ON QuyenGopTien(MaTaiKhoan);
CREATE INDEX IDX_QGT_Ngay            ON QuyenGopTien(NgayGiaoDich);

-- Indexes cho ThanhToan
CREATE INDEX IDX_TT_QGop             ON ThanhToan(MaQuyenGop);

-- Indexes cho ChiTieu
CREATE INDEX IDX_CT_CD               ON ChiTieu(MaChienDich);
CREATE INDEX IDX_CT_NgayChi          ON ChiTieu(NgayChi);

-- Indexes cho TaiTro
CREATE INDEX IDX_TaiTro_DT           ON TaiTro(MaDoiTac);
CREATE INDEX IDX_TaiTro_CD           ON TaiTro(MaChienDich);

-- Indexes cho PhieuQuyenGopVP
CREATE INDEX IDX_PQGVP_TK            ON PhieuQuyenGopVP(MaTaiKhoan);
CREATE INDEX IDX_PQGVP_CD            ON PhieuQuyenGopVP(MaChienDich);

-- Indexes cho PhieuXuatVatPham
CREATE INDEX IDX_PXVP_CD             ON PhieuXuatVatPham(MaChienDich);
CREATE INDEX IDX_PXVP_NgayXuat       ON PhieuXuatVatPham(NgayXuat);

-- Indexes cho ThongBao
CREATE INDEX IDX_TB_TK               ON ThongBao(MaTaiKhoan);
CREATE INDEX IDX_TB_TrangThai        ON ThongBao(TrangThai);

-- Indexes cho TheoDoi
CREATE INDEX IDX_TD_CD               ON TheoDoi(MaChienDich);

COMMIT;
PROMPT >> 03_indexes.sql: Da tao xong tat ca INDEXES.
-- ============================================================
-- FILE: 04_triggers_auto_pk.sql
-- MUC DICH: Tao TRIGGERS tu dong gan Khoa Chinh tu SEQUENCES khi INSERT
-- CHAY SAU: 03_indexes.sql
-- ============================================================

-- Trigger auto PK cho TaiKhoan
CREATE OR REPLACE TRIGGER trg_bi_TaiKhoan
BEFORE INSERT ON TaiKhoan FOR EACH ROW
BEGIN
    IF :NEW.MaTaiKhoan IS NULL THEN
        :NEW.MaTaiKhoan := 'TK' || LPAD(s_taikhoan_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho HoSoSinhVien
CREATE OR REPLACE TRIGGER trg_bi_HoSoSinhVien
BEFORE INSERT ON HoSoSinhVien FOR EACH ROW
BEGIN
    IF :NEW.MaHoSo IS NULL THEN
        :NEW.MaHoSo := 'HS' || LPAD(s_hoso_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho NhatKyHeThong
CREATE OR REPLACE TRIGGER trg_bi_NhatKyHeThong
BEFORE INSERT ON NhatKyHeThong FOR EACH ROW
BEGIN
    IF :NEW.MaNhatKy IS NULL THEN
        :NEW.MaNhatKy := 'NK' || LPAD(s_nhatky_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho DoiTac
CREATE OR REPLACE TRIGGER trg_bi_DoiTac
BEFORE INSERT ON DoiTac FOR EACH ROW
BEGIN
    IF :NEW.MaDoiTac IS NULL THEN
        :NEW.MaDoiTac := 'DT' || LPAD(s_doitac_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho LoaiVatPham
CREATE OR REPLACE TRIGGER trg_bi_LoaiVatPham
BEFORE INSERT ON LoaiVatPham FOR EACH ROW
BEGIN
    IF :NEW.MaLoai IS NULL THEN
        :NEW.MaLoai := 'VP' || LPAD(s_loaivp_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ThamSo
CREATE OR REPLACE TRIGGER trg_bi_ThamSo
BEFORE INSERT ON ThamSo FOR EACH ROW
BEGIN
    IF :NEW.MaThamSo IS NULL THEN
        :NEW.MaThamSo := 'TS' || LPAD(s_thamso_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ChienDich
CREATE OR REPLACE TRIGGER trg_bi_ChienDich
BEFORE INSERT ON ChienDich FOR EACH ROW
BEGIN
    IF :NEW.MaChienDich IS NULL THEN
        :NEW.MaChienDich := 'CD' || LPAD(s_chiendich_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho DuyetChienDich
CREATE OR REPLACE TRIGGER trg_bi_DuyetChienDich
BEFORE INSERT ON DuyetChienDich FOR EACH ROW
BEGIN
    IF :NEW.MaDuyet IS NULL THEN
        :NEW.MaDuyet := 'DC' || LPAD(s_duyet_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho TinTuc
CREATE OR REPLACE TRIGGER trg_bi_TinTuc
BEFORE INSERT ON TinTuc FOR EACH ROW
BEGIN
    IF :NEW.MaTinTuc IS NULL THEN
        :NEW.MaTinTuc := 'TT' || LPAD(s_tintuc_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho BinhLuan
CREATE OR REPLACE TRIGGER trg_bi_BinhLuan
BEFORE INSERT ON BinhLuan FOR EACH ROW
BEGIN
    IF :NEW.MaBinhLuan IS NULL THEN
        :NEW.MaBinhLuan := 'BL' || LPAD(s_binhluan_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ThamGiaTNV
CREATE OR REPLACE TRIGGER trg_bi_ThamGiaTNV
BEFORE INSERT ON ThamGiaTNV FOR EACH ROW
BEGIN
    IF :NEW.MaThamGia IS NULL THEN
        :NEW.MaThamGia := 'TG' || LPAD(s_thamgia_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho CongViec
CREATE OR REPLACE TRIGGER trg_bi_CongViec
BEFORE INSERT ON CongViec FOR EACH ROW
BEGIN
    IF :NEW.MaCongViec IS NULL THEN
        :NEW.MaCongViec := 'CV' || LPAD(s_congviec_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho PhanCong
CREATE OR REPLACE TRIGGER trg_bi_PhanCong
BEFORE INSERT ON PhanCong FOR EACH ROW
BEGIN
    IF :NEW.MaPhanCong IS NULL THEN
        :NEW.MaPhanCong := 'PC' || LPAD(s_phancong_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho DiemDanh
CREATE OR REPLACE TRIGGER trg_bi_DiemDanh
BEFORE INSERT ON DiemDanh FOR EACH ROW
BEGIN
    IF :NEW.MaDiemDanh IS NULL THEN
        :NEW.MaDiemDanh := 'DD' || LPAD(s_diemdanh_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho MinhChungTNV
CREATE OR REPLACE TRIGGER trg_bi_MinhChungTNV
BEFORE INSERT ON MinhChungTNV FOR EACH ROW
BEGIN
    IF :NEW.MaMinhChung IS NULL THEN
        :NEW.MaMinhChung := 'MC' || LPAD(s_minhchungtnv_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho GiayChungNhan
CREATE OR REPLACE TRIGGER trg_bi_GiayChungNhan
BEFORE INSERT ON GiayChungNhan FOR EACH ROW
BEGIN
    IF :NEW.MaChungNhan IS NULL THEN
        :NEW.MaChungNhan := 'GC' || LPAD(s_giaychungnhan_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho QuyenGopTien
CREATE OR REPLACE TRIGGER trg_bi_QuyenGopTien
BEFORE INSERT ON QuyenGopTien FOR EACH ROW
BEGIN
    IF :NEW.MaQuyenGop IS NULL THEN
        :NEW.MaQuyenGop := 'QG' || LPAD(s_quyengop_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ThanhToan
CREATE OR REPLACE TRIGGER trg_bi_ThanhToan
BEFORE INSERT ON ThanhToan FOR EACH ROW
BEGIN
    IF :NEW.MaThanhToan IS NULL THEN
        :NEW.MaThanhToan := 'HD' || LPAD(s_thanhtoan_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho MinhChungChiTieu
CREATE OR REPLACE TRIGGER trg_bi_MinhChungChiTieu
BEFORE INSERT ON MinhChungChiTieu FOR EACH ROW
BEGIN
    IF :NEW.MaMinhChung IS NULL THEN
        :NEW.MaMinhChung := 'MZ' || LPAD(s_minhchungct_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ChiTieu
CREATE OR REPLACE TRIGGER trg_bi_ChiTieu
BEFORE INSERT ON ChiTieu FOR EACH ROW
BEGIN
    IF :NEW.MaChiTieu IS NULL THEN
        :NEW.MaChiTieu := 'CT' || LPAD(s_chitieu_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho TaiTro
CREATE OR REPLACE TRIGGER trg_bi_TaiTro
BEFORE INSERT ON TaiTro FOR EACH ROW
BEGIN
    IF :NEW.MaTaiTro IS NULL THEN
        :NEW.MaTaiTro := 'TR' || LPAD(s_taitro_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho PhieuQuyenGopVP
CREATE OR REPLACE TRIGGER trg_bi_PhieuQuyenGopVP
BEFORE INSERT ON PhieuQuyenGopVP FOR EACH ROW
BEGIN
    IF :NEW.MaPhieuQG IS NULL THEN
        :NEW.MaPhieuQG := 'PQ' || LPAD(s_phieuqgvp_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho PhieuXuatVatPham
CREATE OR REPLACE TRIGGER trg_bi_PhieuXuatVatPham
BEFORE INSERT ON PhieuXuatVatPham FOR EACH ROW
BEGIN
    IF :NEW.MaPhieuXuat IS NULL THEN
        :NEW.MaPhieuXuat := 'PX' || LPAD(s_phieuxuat_id.NEXTVAL, 8, '0');
    END IF;
END;
/

-- Trigger auto PK cho ThongBao
CREATE OR REPLACE TRIGGER trg_bi_ThongBao
BEFORE INSERT ON ThongBao FOR EACH ROW
BEGIN
    IF :NEW.MaThongBao IS NULL THEN
        :NEW.MaThongBao := 'TB' || LPAD(s_thongbao_id.NEXTVAL, 8, '0');
    END IF;
END;
/

COMMIT;
PROMPT >> 04_triggers_auto_pk.sql: Da tao xong tat ca TRIGGERS tu dong gan PK.
-- ============================================================
-- FILE: 05_triggers_business.sql
-- MUC DICH: Implement 9 Triggers theo yeu cau
-- ============================================================

-- 1. TRG_KIEMTRA_SOLUONG_DANGKY
CREATE OR REPLACE TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY
BEFORE INSERT ON ThamGiaTNV
FOR EACH ROW
DECLARE
    v_SoLuongToiDa NUMBER;
    v_SoLuongHienTai NUMBER;
BEGIN
    SELECT SoLuongTNVToiDa, SoLuongHienTai INTO v_SoLuongToiDa, v_SoLuongHienTai
    FROM ChienDich WHERE MaChienDich = :NEW.MaChienDich;
    
    IF v_SoLuongHienTai >= v_SoLuongToiDa THEN
        RAISE_APPLICATION_ERROR(-20002, 'Chiáº¿n dá»‹ch Ä‘Ã£ Ä‘á»§ sá»‘ lÆ°á»£ng tÃ¬nh nguyá»‡n viÃªn.');
    END IF;
END;
/

-- 2. TRG_CAPNHAT_SOLUONG_TNV
CREATE OR REPLACE TRIGGER TRG_CAPNHAT_SOLUONG_TNV
AFTER INSERT OR DELETE ON ThamGiaTNV
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE ChienDich SET SoLuongHienTai = NVL(SoLuongHienTai, 0) + 1
        WHERE MaChienDich = :NEW.MaChienDich;
    ELSIF DELETING THEN
        UPDATE ChienDich SET SoLuongHienTai = NVL(SoLuongHienTai, 0) - 1
        WHERE MaChienDich = :OLD.MaChienDich;
    END IF;
END;
/

-- 3. TRG_KIEMTRA_TRUNG_LICH
CREATE OR REPLACE TRIGGER TRG_KIEMTRA_TRUNG_LICH
BEFORE INSERT ON ThamGiaTNV
FOR EACH ROW
DECLARE
    v_NgayBatDauMoi DATE;
    v_NgayKetThucMoi DATE;
    v_Count NUMBER;
BEGIN
    SELECT NgayBatDau, NVL(NgayKetThuc, NgayBatDau) INTO v_NgayBatDauMoi, v_NgayKetThucMoi
    FROM ChienDich WHERE MaChienDich = :NEW.MaChienDich;

    SELECT COUNT(*) INTO v_Count
    FROM ThamGiaTNV tg
    JOIN ChienDich cd ON tg.MaChienDich = cd.MaChienDich
    WHERE tg.MaTaiKhoan = :NEW.MaTaiKhoan
      AND tg.TrangThaiDuyet IN ('ChoDuyet', 'DaDuyet')
      AND (
          (v_NgayBatDauMoi BETWEEN cd.NgayBatDau AND NVL(cd.NgayKetThuc, cd.NgayBatDau)) OR
          (v_NgayKetThucMoi BETWEEN cd.NgayBatDau AND NVL(cd.NgayKetThuc, cd.NgayBatDau)) OR
          (cd.NgayBatDau BETWEEN v_NgayBatDauMoi AND v_NgayKetThucMoi)
      );

    IF v_Count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'TrÃ¹ng lá»‹ch vá»›i chiáº¿n dá»‹ch khÃ¡c Ä‘ang tham gia hoáº·c chá» duyá»‡t.');
    END IF;
END;
/

-- 4. TRG_TINHDIEM_THUONG
CREATE OR REPLACE TRIGGER TRG_TINHDIEM_THUONG
AFTER UPDATE OF TrangThaiDuyet ON ThamGiaTNV
FOR EACH ROW
WHEN (NEW.TrangThaiDuyet = 'HoanThanh' AND OLD.TrangThaiDuyet != 'HoanThanh')
DECLARE
    v_DiemThuong NUMBER;
BEGIN
    SELECT NVL(DiemThuong, 0) INTO v_DiemThuong
    FROM ChienDich WHERE MaChienDich = :NEW.MaChienDich;

    UPDATE HoSoSinhVien
    SET TongDiem = NVL(TongDiem, 0) + v_DiemThuong
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
END;
/

-- 5. TRG_CHANXOA_CHIENDICH
CREATE OR REPLACE TRIGGER TRG_CHANXOA_CHIENDICH
BEFORE DELETE ON ChienDich
FOR EACH ROW
DECLARE
    v_Count NUMBER;
BEGIN
    IF :OLD.TrangThai = 'DangHoatDong' THEN
        RAISE_APPLICATION_ERROR(-20005, 'KhÃ´ng thá»ƒ xÃ³a chiáº¿n dá»‹ch Ä‘ang hoáº¡t Ä‘á»™ng. HÃ£y Ä‘á»•i tráº¡ng thÃ¡i sang Há»§y.');
    END IF;

    SELECT COUNT(*) INTO v_Count FROM ThamGiaTNV WHERE MaChienDich = :OLD.MaChienDich;
    IF v_Count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'KhÃ´ng thá»ƒ xÃ³a chiáº¿n dá»‹ch Ä‘Ã£ cÃ³ ngÆ°á»i Ä‘Äƒng kÃ½. HÃ£y Ä‘á»•i tráº¡ng thÃ¡i sang Há»§y.');
    END IF;
END;
/

-- 6. TRG_KIEMTRA_TUOI_TNV
CREATE OR REPLACE TRIGGER TRG_KIEMTRA_TUOI_TNV
BEFORE INSERT OR UPDATE ON HoSoSinhVien
FOR EACH ROW
DECLARE
    v_TuoiToiThieu NUMBER;
BEGIN
    SELECT TO_NUMBER(GiaTri) INTO v_TuoiToiThieu FROM ThamSo WHERE TenThamSo = 'TUOI_TOI_THIEU';
    IF MONTHS_BETWEEN(SYSDATE, :NEW.NgaySinh) / 12 < v_TuoiToiThieu THEN
        RAISE_APPLICATION_ERROR(-20007, 'TÃ¬nh nguyá»‡n viÃªn pháº£i tá»« Ä‘á»§ ' || v_TuoiToiThieu || ' tuá»•i trá»Ÿ lÃªn.');
    END IF;
END;
/

-- 7. TRG_HUY_CHIENDICH_DONGLOAT
CREATE OR REPLACE TRIGGER TRG_HUY_CHIENDICH_DONGLOAT
AFTER UPDATE OF TrangThai ON ChienDich
FOR EACH ROW
WHEN (NEW.TrangThai = 'Huy')
BEGIN
    UPDATE ThamGiaTNV
    SET TrangThaiDuyet = 'Huy'
    WHERE MaChienDich = :NEW.MaChienDich;
END;
/

-- 8. TRG_KIEMTRA_THOIGIAN
CREATE OR REPLACE TRIGGER TRG_KIEMTRA_THOIGIAN
BEFORE INSERT OR UPDATE ON ChienDich
FOR EACH ROW
BEGIN
    IF :NEW.NgayBatDau < TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20008, 'NgÃ y báº¯t Ä‘áº§u pháº£i lá»›n hÆ¡n hoáº·c báº±ng ngÃ y hiá»‡n táº¡i.');
    END IF;
    IF :NEW.NgayKetThuc IS NOT NULL AND :NEW.NgayKetThuc < :NEW.NgayBatDau THEN
        RAISE_APPLICATION_ERROR(-20009, 'NgÃ y káº¿t thÃºc pháº£i lá»›n hÆ¡n hoáº·c báº±ng ngÃ y báº¯t Ä‘áº§u.');
    END IF;
END;
/

-- 9. TRG_GIOIHAN_NHIEMVU
CREATE OR REPLACE TRIGGER TRG_GIOIHAN_NHIEMVU
BEFORE INSERT ON PhanCong
FOR EACH ROW
DECLARE
    v_Count NUMBER;
    v_MaxTasks VARCHAR2(10);
BEGIN
    SELECT TO_NUMBER(GiaTri) INTO v_MaxTasks FROM ThamSo WHERE TenThamSo = 'SO_NHIEM_VU_TOI_DA';
    
    SELECT COUNT(*) INTO v_Count
    FROM PhanCong
    WHERE MaThamGia = :NEW.MaThamGia
      AND TrangThai IN ('ChuaBatDau', 'DangThucHien');
      
    IF v_Count >= v_MaxTasks THEN
        RAISE_APPLICATION_ERROR(-20010, 'TÃ¬nh nguyá»‡n viÃªn chá»‰ Ä‘Æ°á»£c nháº­n tá»‘i Ä‘a ' || v_MaxTasks || ' nhiá»‡m vá»¥ Ä‘ang chá» hoáº·c Ä‘ang xá»­ lÃ½ cÃ¹ng lÃºc.');
    END IF;
END;
/
-- ============================================================
-- FILE: 06_stored_procedures.sql
-- MUC DICH: Implement 31 SPs
-- ============================================================

-- 1. SP_DANGKYTAIKHOAN_TNV
CREATE OR REPLACE PROCEDURE SP_DANGKYTAIKHOAN_TNV (
    p_TenDN IN VARCHAR2,
    p_MK IN VARCHAR2,
    p_HoTen IN NVARCHAR2,
    p_MSSV IN VARCHAR2,
    p_SDT IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_Khoa IN NVARCHAR2
)
AS
    v_MaTK VARCHAR2(10);
BEGIN
    INSERT INTO TaiKhoan(MaTaiKhoan, TenDangNhap, MatKhau, Email, VaiTro, TrangThai)
    VALUES (NULL, p_TenDN, p_MK, p_Email, 'TinhNguyenVien', 'HoatDong')
    RETURNING MaTaiKhoan INTO v_MaTK;
    
    INSERT INTO HoSoSinhVien(MaHoSo, MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi)
    VALUES (NULL, v_MaTK, p_HoTen, p_MSSV, TO_DATE('2000-01-01', 'YYYY-MM-DD'), N'Khac', p_Khoa, 'Unknown', p_SDT, 'Unknown');
END;
/

-- 2. SP_CAPNHAT_HOSO_TNV
CREATE OR REPLACE PROCEDURE SP_CAPNHAT_HOSO_TNV (
    p_MaTK IN VARCHAR2,
    p_HoTen IN NVARCHAR2,
    p_SDT IN VARCHAR2,
    p_Khoa IN NVARCHAR2
)
AS
BEGIN
    UPDATE HoSoSinhVien
    SET HoTen = p_HoTen, SoDienThoai = p_SDT, Khoa = p_Khoa
    WHERE MaTaiKhoan = p_MaTK;
END;
/

-- 3. SP_CAPNHAT_VAITRO
CREATE OR REPLACE PROCEDURE SP_CAPNHAT_VAITRO (
    p_MaTK IN VARCHAR2,
    p_VaiTroMoi IN VARCHAR2,
    p_MaCD IN VARCHAR2 DEFAULT NULL
)
AS
BEGIN
    UPDATE TaiKhoan
    SET VaiTro = p_VaiTroMoi
    WHERE MaTaiKhoan = p_MaTK;
    
    IF p_VaiTroMoi = 'BanDieuHanh' THEN
        IF p_MaCD IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Cap nhat BanDieuHanh yeu cau MaChienDich');
        END IF;
        DECLARE
            v_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_count FROM BanDieuHanh WHERE MaTaiKhoan = p_MaTK;
            IF v_count = 0 THEN
                INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (p_MaTK, p_MaCD);
            ELSE
                UPDATE BanDieuHanh SET MaChienDich = p_MaCD WHERE MaTaiKhoan = p_MaTK;
            END IF;
        END;
    ELSE
        DELETE FROM BanDieuHanh WHERE MaTaiKhoan = p_MaTK;
    END IF;
END;
/

-- 4. SP_KIEMTRA_QUYEN
CREATE OR REPLACE PROCEDURE SP_KIEMTRA_QUYEN (
    p_MaTK IN VARCHAR2,
    p_HanhDong IN NVARCHAR2,
    p_Allowed OUT NUMBER
)
AS
    v_VaiTro VARCHAR2(20);
BEGIN
    p_Allowed := 0;
    SELECT VaiTro INTO v_VaiTro FROM TaiKhoan WHERE MaTaiKhoan = p_MaTK;
    IF v_VaiTro IN ('QuanTriVien', 'BanQuanLy', 'BanDieuHanh') THEN
        p_Allowed := 1;
    ELSIF v_VaiTro = 'TinhNguyenVien' AND p_HanhDong = 'DangKy' THEN
        p_Allowed := 1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN p_Allowed := 0;
END;
/

-- 5. SP_LOG_ACTION
CREATE OR REPLACE PROCEDURE SP_LOG_ACTION (
    p_MaTK IN VARCHAR2,
    p_HanhDong IN NVARCHAR2,
    p_ChiTiet IN CLOB
)
AS
BEGIN
    INSERT INTO NhatKyHeThong(MaNhatKy, MaTaiKhoan, HanhDong, ChiTiet)
    VALUES (NULL, p_MaTK, p_HanhDong, p_ChiTiet);
END;
/

-- 6. SP_THEM_CHIENDICH_MOI
CREATE OR REPLACE PROCEDURE SP_THEM_CHIENDICH_MOI (
    p_TenCD IN NVARCHAR2,
    p_NgayBD IN DATE,
    p_NgayKT IN DATE,
    p_MoTa IN CLOB,
    p_MaNguoiTao IN VARCHAR2
)
AS
BEGIN
    INSERT INTO ChienDich(MaChienDich, TenChienDich, NgayBatDau, NgayKetThuc, MoTa, MaNguoiTao)
    VALUES (NULL, p_TenCD, p_NgayBD, p_NgayKT, p_MoTa, p_MaNguoiTao);
END;
/

-- 7. SP_CAPNHAT_CHIENDICH
CREATE OR REPLACE PROCEDURE SP_CAPNHAT_CHIENDICH (
    p_MaCD IN VARCHAR2,
    p_MoTa IN CLOB,
    p_ThoiGian IN DATE
)
AS
BEGIN
    UPDATE ChienDich
    SET MoTa = p_MoTa, NgayBatDau = p_ThoiGian
    WHERE MaChienDich = p_MaCD;
END;
/

-- 8. SP_XOA_CHIENDICH
CREATE OR REPLACE PROCEDURE SP_XOA_CHIENDICH (
    p_MaCD IN VARCHAR2
)
AS
BEGIN
    DELETE FROM ChienDich WHERE MaChienDich = p_MaCD;
END;
/

-- 9. SP_MO_DANGKY_CD
CREATE OR REPLACE PROCEDURE SP_MO_DANGKY_CD (
    p_MaCD IN VARCHAR2
)
AS
BEGIN
    UPDATE ChienDich SET TrangThai = 'DangHoatDong' WHERE MaChienDich = p_MaCD;
END;
/

-- 10. SP_DONG_CHIENDICH
CREATE OR REPLACE PROCEDURE SP_DONG_CHIENDICH (
    p_MaCD IN VARCHAR2
)
AS
BEGIN
    UPDATE ChienDich SET TrangThai = 'DaKetThuc' WHERE MaChienDich = p_MaCD;
END;
/

-- 11. SP_THEM_CONGVIEC
CREATE OR REPLACE PROCEDURE SP_THEM_CONGVIEC (
    p_MaCD IN VARCHAR2,
    p_TenCV IN NVARCHAR2,
    p_SoLuongCan IN NUMBER
)
AS
BEGIN
    INSERT INTO CongViec(MaCongViec, MaChienDich, TenCongViec, SoLuongTNVCan)
    VALUES (NULL, p_MaCD, p_TenCV, p_SoLuongCan);
END;
/

-- 12. SP_PHANCONG_TNV
CREATE OR REPLACE PROCEDURE SP_PHANCONG_TNV (
    p_MaThamGia IN VARCHAR2,
    p_MaCongViec IN VARCHAR2
)
AS
BEGIN
    INSERT INTO PhanCong(MaPhanCong, MaThamGia, MaCongViec, TrangThai)
    VALUES (NULL, p_MaThamGia, p_MaCongViec, 'ChuaBatDau');
END;
/

-- 13. SP_TNV_DANGKY_THAMGIA
CREATE OR REPLACE PROCEDURE SP_TNV_DANGKY_THAMGIA (
    p_MaTK IN VARCHAR2,
    p_MaCD IN VARCHAR2
)
AS
BEGIN
    INSERT INTO ThamGiaTNV(MaThamGia, MaTaiKhoan, MaChienDich, TrangThaiDuyet)
    VALUES (NULL, p_MaTK, p_MaCD, 'ChoDuyet');
END;
/

-- 14. SP_DUYET_DANGKY_TNV
CREATE OR REPLACE PROCEDURE SP_DUYET_DANGKY_TNV (
    p_MaThamGia IN VARCHAR2,
    p_TrangThaiMoi IN VARCHAR2
)
AS
BEGIN
    UPDATE ThamGiaTNV SET TrangThaiDuyet = p_TrangThaiMoi WHERE MaThamGia = p_MaThamGia;
END;
/

-- 15. SP_DIEMDANH_TNV
CREATE OR REPLACE PROCEDURE SP_DIEMDANH_TNV (
    p_MaPhanCong IN VARCHAR2,
    p_Ngay IN DATE,
    p_TrangThai IN VARCHAR2
)
AS
    v_MaThamGia VARCHAR2(10);
BEGIN
    SELECT MaThamGia INTO v_MaThamGia FROM PhanCong WHERE MaPhanCong = p_MaPhanCong;
    INSERT INTO DiemDanh(MaDiemDanh, MaThamGia, NgayDiemDanh, TrangThai)
    VALUES (NULL, v_MaThamGia, p_Ngay, p_TrangThai);
END;
/

-- 16. SP_CAPNHAT_MINHCHUNG
CREATE OR REPLACE PROCEDURE SP_CAPNHAT_MINHCHUNG (
    p_MaThamGia IN VARCHAR2,
    p_LinkAnh IN VARCHAR2,
    p_Loai IN NVARCHAR2
)
AS
BEGIN
    INSERT INTO MinhChungTNV(MaMinhChung, MaThamGia, HinhAnh_URL, LoaiMinhChung)
    VALUES (NULL, p_MaThamGia, p_LinkAnh, p_Loai);
END;
/

-- 17. SP_DANHGIA_TNV
CREATE OR REPLACE PROCEDURE SP_DANHGIA_TNV (
    p_MaThamGia IN VARCHAR2,
    p_Diem IN NUMBER,
    p_NhanXet IN CLOB
)
AS
BEGIN
    UPDATE ThamGiaTNV SET DiemDanhGia = p_Diem WHERE MaThamGia = p_MaThamGia;
END;
/

-- 18. SP_CAP_CHUNGNHAN_CD
CREATE OR REPLACE PROCEDURE SP_CAP_CHUNGNHAN_CD (
    p_MaCD IN VARCHAR2
)
AS
    v_GioToiThieu NUMBER;
BEGIN
    -- Logic Hierarchy: Check ChienDich first, fallback to ThamSo
    SELECT NVL(GioToiThieuCN, (SELECT TO_NUMBER(GiaTri) FROM ThamSo WHERE TenThamSo = 'GIO_CONG_MAC_DINH'))
    INTO v_GioToiThieu
    FROM ChienDich
    WHERE MaChienDich = p_MaCD;

    -- Issue certificate only if accumulated hours >= v_GioToiThieu
    INSERT INTO GiayChungNhan(MaChungNhan, MaThamGia, NgayCap, XepLoai)
    SELECT NULL, tg.MaThamGia, SYSDATE, SF_GET_XEP_LOAI(tg.MaThamGia)
    FROM ThamGiaTNV tg
    WHERE tg.MaChienDich = p_MaCD 
      AND tg.TrangThaiDuyet = 'HoanThanh'
      AND (SELECT NVL(SUM(SoGioGhiNhan), 0) FROM DiemDanh dd WHERE dd.MaThamGia = tg.MaThamGia) >= v_GioToiThieu;
END;
/

-- 19. SP_GHI_NHAN_QUYENGOP
CREATE OR REPLACE PROCEDURE SP_GHI_NHAN_QUYENGOP (
    p_MaTK IN VARCHAR2,
    p_MaCD IN VARCHAR2,
    p_SoTien IN NUMBER
)
AS
BEGIN
    INSERT INTO QuyenGopTien(MaQuyenGop, MaTaiKhoan, MaChienDich, SoTien, PhuongThuc)
    VALUES (NULL, p_MaTK, p_MaCD, p_SoTien, 'ChuyenKhoan');
END;
/

-- 20. SP_THEM_PHIEU_CHI
CREATE OR REPLACE PROCEDURE SP_THEM_PHIEU_CHI (
    p_MaCD IN VARCHAR2,
    p_SoTien IN NUMBER,
    p_MucDich IN NVARCHAR2
)
AS
BEGIN
    INSERT INTO ChiTieu(MaChiTieu, MaChienDich, TenKhoanChi, SoTienChi, NgayChi, MucDich)
    VALUES (NULL, p_MaCD, p_MucDich, p_SoTien, SYSDATE, p_MucDich);
END;
/

-- 21. SP_THEM_DOITAC
CREATE OR REPLACE PROCEDURE SP_THEM_DOITAC (
    p_TenDoiTac IN NVARCHAR2,
    p_SDT IN VARCHAR2,
    p_Email IN VARCHAR2
)
AS
BEGIN
    INSERT INTO DoiTac(MaDoiTac, TenDoiTac, SoDienThoai, Email)
    VALUES (NULL, p_TenDoiTac, p_SDT, p_Email);
END;
/

-- 22. SP_NHAPKHO_VATPHAM
CREATE OR REPLACE PROCEDURE SP_NHAPKHO_VATPHAM (
    p_MaCD IN VARCHAR2,
    p_MaLoai IN VARCHAR2,
    p_SL IN NUMBER
)
AS
    v_MaPhieu VARCHAR2(10);
BEGIN
    INSERT INTO PhieuQuyenGopVP(MaPhieuQG, MaTaiKhoan, MaChienDich, NguoiNhan)
    VALUES (NULL, (SELECT MIN(MaTaiKhoan) FROM TaiKhoan WHERE VaiTro = 'BanQuanLy'), p_MaCD, 'Admin')
    RETURNING MaPhieuQG INTO v_MaPhieu;
    
    INSERT INTO ChiTietQuyenGopVP(MaPhieuQG, MaLoai, SoLuong)
    VALUES (v_MaPhieu, p_MaLoai, p_SL);
    
    UPDATE LoaiVatPham SET SoLuongTon = SoLuongTon + p_SL WHERE MaLoai = p_MaLoai;
END;
/

-- 23. SP_XUATKHO_VATPHAM
CREATE OR REPLACE PROCEDURE SP_XUATKHO_VATPHAM (
    p_MaCD IN VARCHAR2,
    p_MaLoai IN VARCHAR2,
    p_SL IN NUMBER,
    p_NguoiNhan IN NVARCHAR2
)
AS
    v_MaPhieu VARCHAR2(10);
BEGIN
    INSERT INTO PhieuXuatVatPham(MaPhieuXuat, MaChienDich, NgayXuat, NguoiXuat, NguoiNhan)
    VALUES (NULL, p_MaCD, SYSDATE, 'Admin', p_NguoiNhan)
    RETURNING MaPhieuXuat INTO v_MaPhieu;
    
    INSERT INTO ChiTietXuatVP(MaPhieuXuat, MaLoai, SoLuong)
    VALUES (v_MaPhieu, p_MaLoai, p_SL);
    
    UPDATE LoaiVatPham SET SoLuongTon = SoLuongTon - p_SL WHERE MaLoai = p_MaLoai;
END;
/

-- 24. SP_CAPNHAT_VATPHAM
CREATE OR REPLACE PROCEDURE SP_CAPNHAT_VATPHAM (
    p_MaLoai IN VARCHAR2,
    p_TenMoi IN NVARCHAR2,
    p_DonVi IN NVARCHAR2
)
AS
BEGIN
    UPDATE LoaiVatPham SET TenLoai = p_TenMoi, DonViTinh = p_DonVi WHERE MaLoai = p_MaLoai;
END;
/

-- 25. SP_LAY_DS_CHIENDICH_MO
CREATE OR REPLACE PROCEDURE SP_LAY_DS_CHIENDICH_MO (
    p_Cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM ChienDich WHERE TrangThai = 'DangHoatDong';
END;
/

-- 26. SP_LAY_TNV_THEO_CD
CREATE OR REPLACE PROCEDURE SP_LAY_TNV_THEO_CD (
    p_MaCD IN VARCHAR2,
    p_Cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM ThamGiaTNV WHERE MaChienDich = p_MaCD;
END;
/

-- 27. SP_LAY_LICHSU_TNV
CREATE OR REPLACE PROCEDURE SP_LAY_LICHSU_TNV (
    p_MaTK IN VARCHAR2,
    p_Cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM ThamGiaTNV WHERE MaTaiKhoan = p_MaTK;
END;
/

-- 28. SP_LAY_VP_TONKHO_THAP
CREATE OR REPLACE PROCEDURE SP_LAY_VP_TONKHO_THAP (
    p_Cursor OUT SYS_REFCURSOR
)
AS
    v_Nguong NUMBER;
BEGIN
    SELECT TO_NUMBER(GiaTri) INTO v_Nguong FROM ThamSo WHERE TenThamSo = 'NGUONG_TON_KHO_CANH_BAO';
    OPEN p_Cursor FOR
    SELECT * FROM LoaiVatPham WHERE SoLuongTon < v_Nguong;
END;
/

-- 29. SP_LAY_DS_TINTUC
CREATE OR REPLACE PROCEDURE SP_LAY_DS_TINTUC (
    p_MaCD IN VARCHAR2,
    p_Cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM TinTuc WHERE MaChienDich = p_MaCD;
END;
/

-- 30. SP_THAYDOI_THAMSO
CREATE OR REPLACE PROCEDURE SP_THAYDOI_THAMSO (
    p_MaTS IN VARCHAR2,
    p_GiaTriMoi IN VARCHAR2
)
AS
BEGIN
    UPDATE ThamSo SET GiaTri = p_GiaTriMoi WHERE MaThamSo = p_MaTS;
END;
/

-- 31. SP_BAOCAO_HIEUQUA_CD
CREATE OR REPLACE PROCEDURE SP_BAOCAO_HIEUQUA_CD (
    p_MaCD IN VARCHAR2,
    p_Cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_Cursor FOR
    SELECT 
        (SELECT NVL(SUM(SoTien), 0) FROM QuyenGopTien WHERE MaChienDich = p_MaCD) AS TongThu,
        (SELECT NVL(SUM(SoTienChi), 0) FROM ChiTieu WHERE MaChienDich = p_MaCD) AS TongChi
    FROM DUAL;
END;
/

-- 32. SP_THIET_LAP_BDH
CREATE OR REPLACE PROCEDURE SP_THIET_LAP_BDH (
    p_MaTK IN VARCHAR2,
    p_MaCD IN VARCHAR2
)
AS
    v_VaiTro VARCHAR2(20);
BEGIN
    SELECT VaiTro INTO v_VaiTro FROM TaiKhoan WHERE MaTaiKhoan = p_MaTK;
    IF v_VaiTro != 'BanDieuHanh' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tai khoan khong co vai tro BanDieuHanh');
    END IF;
    
    -- Insert hoac update neu da ton tai (xu ly Unique/PK constraint)
    DECLARE
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM BanDieuHanh WHERE MaTaiKhoan = p_MaTK;
        IF v_count = 0 THEN
            INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (p_MaTK, p_MaCD);
        ELSE
            UPDATE BanDieuHanh SET MaChienDich = p_MaCD WHERE MaTaiKhoan = p_MaTK;
        END IF;
    END;
END;
/

-- ============================================================
-- FILE: 07_stored_functions.sql
-- MUC DICH: Implement 6 SFs
-- ============================================================

-- 1. SF_TINH_TONG_GIO_TNV
CREATE OR REPLACE FUNCTION SF_TINH_TONG_GIO_TNV (
    p_MaTaiKhoan IN VARCHAR2
) RETURN NUMBER
AS
    v_TongGio NUMBER;
BEGIN
    SELECT NVL(SUM(dd.SoGioGhiNhan), 0) INTO v_TongGio
    FROM DiemDanh dd
    JOIN ThamGiaTNV tg ON dd.MaThamGia = tg.MaThamGia
    WHERE tg.MaTaiKhoan = p_MaTaiKhoan;
    
    RETURN v_TongGio;
END;
/

-- 2. SF_TINH_NGAN_QUY_CD
CREATE OR REPLACE FUNCTION SF_TINH_NGAN_QUY_CD (
    p_MaChienDich IN VARCHAR2
) RETURN NUMBER
AS
    v_TongThu NUMBER;
    v_TongChi NUMBER;
BEGIN
    SELECT NVL(SUM(SoTien), 0) INTO v_TongThu FROM QuyenGopTien WHERE MaChienDich = p_MaChienDich;
    SELECT NVL(SUM(SoTienChi), 0) INTO v_TongChi FROM ChiTieu WHERE MaChienDich = p_MaChienDich;
    RETURN v_TongThu - v_TongChi;
END;
/

-- 3. SF_CHECK_DK_THAMGIA
CREATE OR REPLACE FUNCTION SF_CHECK_DK_THAMGIA (
    p_MaTK IN VARCHAR2,
    p_MaCD IN VARCHAR2
) RETURN NUMBER -- 1 for True, 0 for False
AS
    v_SoLuongToiDa NUMBER;
    v_SoLuongHienTai NUMBER;
    v_NgayBatDauMoi DATE;
    v_NgayKetThucMoi DATE;
    v_Count NUMBER;
BEGIN
    SELECT SoLuongTNVToiDa, NVL(SoLuongHienTai, 0), NgayBatDau, NVL(NgayKetThuc, NgayBatDau) 
    INTO v_SoLuongToiDa, v_SoLuongHienTai, v_NgayBatDauMoi, v_NgayKetThucMoi
    FROM ChienDich WHERE MaChienDich = p_MaCD;
    
    IF v_SoLuongHienTai >= v_SoLuongToiDa THEN
        RETURN 0;
    END IF;

    SELECT COUNT(*) INTO v_Count
    FROM ThamGiaTNV tg
    JOIN ChienDich cd ON tg.MaChienDich = cd.MaChienDich
    WHERE tg.MaTaiKhoan = p_MaTK
      AND tg.TrangThaiDuyet IN ('ChoDuyet', 'DaDuyet')
      AND (
          (v_NgayBatDauMoi BETWEEN cd.NgayBatDau AND NVL(cd.NgayKetThuc, cd.NgayBatDau)) OR
          (v_NgayKetThucMoi BETWEEN cd.NgayBatDau AND NVL(cd.NgayKetThuc, cd.NgayBatDau)) OR
          (cd.NgayBatDau BETWEEN v_NgayBatDauMoi AND v_NgayKetThucMoi)
      );

    IF v_Count > 0 THEN
        RETURN 0;
    END IF;

    RETURN 1;
END;
/

-- 4. SF_THONGKE_TNV_KHOA
CREATE OR REPLACE FUNCTION SF_THONGKE_TNV_KHOA (
    p_Khoa IN NVARCHAR2
) RETURN NUMBER
AS
    v_Count NUMBER;
BEGIN
    SELECT COUNT(DISTINCT hs.MaTaiKhoan) INTO v_Count
    FROM HoSoSinhVien hs
    JOIN ThamGiaTNV tg ON hs.MaTaiKhoan = tg.MaTaiKhoan
    WHERE hs.Khoa = p_Khoa AND tg.TrangThaiDuyet IN ('DaDuyet', 'HoanThanh');
    RETURN v_Count;
END;
/

-- 5. SF_GET_XEP_LOAI
CREATE OR REPLACE FUNCTION SF_GET_XEP_LOAI (
    p_MaThamGia IN VARCHAR2
) RETURN VARCHAR2
AS
    v_Diem NUMBER; v_Gio NUMBER;
    v_DiemXS NUMBER; v_GioXS NUMBER;
    v_DiemT NUMBER; v_GioT NUMBER;
    v_DiemK NUMBER; v_GioK NUMBER;
BEGIN
    SELECT NVL(DiemDanhGia, 0) INTO v_Diem FROM ThamGiaTNV WHERE MaThamGia = p_MaThamGia;
    SELECT NVL(SUM(SoGioGhiNhan), 0) INTO v_Gio FROM DiemDanh WHERE MaThamGia = p_MaThamGia;
    
    SELECT TO_NUMBER(GiaTri) INTO v_DiemXS FROM ThamSo WHERE TenThamSo = 'DIEM_XUAT_SAC';
    SELECT TO_NUMBER(GiaTri) INTO v_GioXS FROM ThamSo WHERE TenThamSo = 'GIO_XUAT_SAC';
    SELECT TO_NUMBER(GiaTri) INTO v_DiemT FROM ThamSo WHERE TenThamSo = 'DIEM_TOT';
    SELECT TO_NUMBER(GiaTri) INTO v_GioT FROM ThamSo WHERE TenThamSo = 'GIO_TOT';
    SELECT TO_NUMBER(GiaTri) INTO v_DiemK FROM ThamSo WHERE TenThamSo = 'DIEM_KHA';
    SELECT TO_NUMBER(GiaTri) INTO v_GioK FROM ThamSo WHERE TenThamSo = 'GIO_KHA';
    
    IF v_Diem >= v_DiemXS AND v_Gio >= v_GioXS THEN
        RETURN 'XuatSac';
    ELSIF v_Diem >= v_DiemT AND v_Gio >= v_GioT THEN
        RETURN 'Tot';
    ELSIF v_Diem >= v_DiemK AND v_Gio >= v_GioK THEN
        RETURN 'Kha';
    ELSE
        RETURN 'TrungBinh';
    END IF;
END;
/

-- 6. SF_KIEMTRA_TONKHO_VP
CREATE OR REPLACE FUNCTION SF_KIEMTRA_TONKHO_VP (
    p_MaLoai IN VARCHAR2
) RETURN NUMBER
AS
    v_SoLuong NUMBER;
BEGIN
    SELECT SoLuongTon INTO v_SoLuong FROM LoaiVatPham WHERE MaLoai = p_MaLoai;
    RETURN v_SoLuong;
END;
/
-- ============================================================
-- FILE: 08_SeedData.sql
-- MUC DICH: Tong hop cac lenh INSERT du lieu mau (Seed Data) cho toan bo database.
-- ============================================================
SET SERVEROUTPUT ON;
SET DEFINE OFF;
DECLARE
    -- Mang luu ID de dung cho viec map FK
    TYPE t_arr IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    v_tk_admin t_arr;
    v_tk_dieuhanh t_arr;
    v_tk_tnv t_arr;
    v_cd_ids t_arr;
    v_dt_ids t_arr;
    v_loai_ids t_arr;
    v_tg_ids t_arr;
    v_cv_ids t_arr;
    v_pc_ids t_arr;
    
    v_tmp VARCHAR2(10);
    v_tmp2 VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bat dau tao Seed Data...');

    -- 0. THAM SO HE THONG (Phai insert truoc vi Triggers va Functions phu thuoc)
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('TUOI_TOI_THIEU', '16', 'Tuoi toi thieu de tham gia tinh nguyen');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('SO_NHIEM_VU_TOI_DA', '5', 'So nhiem vu toi da 1 TNV duoc nhan cung luc');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('GIO_CONG_MAC_DINH', '8', 'So gio toi thieu mac dinh de nhan chung nhan');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('DIEM_XUAT_SAC', '9', 'Nguong diem xep loai Xuat Sac');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('GIO_XUAT_SAC', '40', 'Nguong gio xep loai Xuat Sac');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('DIEM_TOT', '7', 'Nguong diem xep loai Tot');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('GIO_TOT', '30', 'Nguong gio xep loai Tot');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('DIEM_KHA', '5', 'Nguong diem xep loai Kha');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('GIO_KHA', '20', 'Nguong gio xep loai Kha');
    INSERT INTO ThamSo(TenThamSo, GiaTri, GhiChu) VALUES ('NGUONG_TON_KHO_CANH_BAO', '10', 'Nguong canh bao ton kho thap');
    DBMS_OUTPUT.PUT_LINE('>> Da insert ThamSo.');

    -- Disable cac triggers nghiep vu de insert du lieu mau (ngay qua khu, trung lich, ...)
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_THOIGIAN DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_TRUNG_LICH DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY DISABLE';
    DBMS_OUTPUT.PUT_LINE('>> Da disable triggers nghiep vu de insert seed data.');

    -- 1. TAI KHOAN QUAN TRI (Ban Quan Ly - 2 User)
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('admin01', '123456', 'admin01@vnuhcm.edu.vn', 'BanQuanLy', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_admin(1) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Admin User 01', 'AD001', DATE '1995-01-01', 'Nam', 'Quan Tri', 'Admin', '0901234561', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('admin02', '123456', 'admin02@vnuhcm.edu.vn', 'BanQuanLy', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_admin(2) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Admin User 02', 'AD002', DATE '1995-01-01', 'Nam', 'Quan Tri', 'Admin', '0901234562', 'TP.HCM');

    -- 2. TAI KHOAN BAN DIEU HANH (20 User - Dieu hanh chien dich 1-to-1)
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh01', '123456', 'dieuhanh01@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(1) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 01', 'DH001', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876501', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh02', '123456', 'dieuhanh02@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(2) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 02', 'DH002', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876502', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh03', '123456', 'dieuhanh03@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(3) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 03', 'DH003', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876503', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh04', '123456', 'dieuhanh04@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(4) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 04', 'DH004', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876504', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh05', '123456', 'dieuhanh05@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(5) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 05', 'DH005', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876505', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh06', '123456', 'dieuhanh06@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(6) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 06', 'DH006', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876506', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh07', '123456', 'dieuhanh07@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(7) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 07', 'DH007', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876507', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh08', '123456', 'dieuhanh08@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(8) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 08', 'DH008', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876508', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh09', '123456', 'dieuhanh09@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(9) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 09', 'DH009', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876509', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh10', '123456', 'dieuhanh10@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(10) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 10', 'DH010', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876510', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh11', '123456', 'dieuhanh11@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(11) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 11', 'DH011', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876511', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh12', '123456', 'dieuhanh12@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(12) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 12', 'DH012', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876512', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh13', '123456', 'dieuhanh13@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(13) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 13', 'DH013', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876513', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh14', '123456', 'dieuhanh14@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(14) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 14', 'DH014', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876514', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh15', '123456', 'dieuhanh15@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(15) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 15', 'DH015', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876515', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh16', '123456', 'dieuhanh16@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(16) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 16', 'DH016', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876516', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh17', '123456', 'dieuhanh17@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(17) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 17', 'DH017', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876517', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh18', '123456', 'dieuhanh18@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(18) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 18', 'DH018', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876518', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh19', '123456', 'dieuhanh19@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(19) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 19', 'DH019', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876519', 'TP.HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('dieuhanh20', '123456', 'dieuhanh20@vnuhcm.edu.vn', 'BanDieuHanh', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_dieuhanh(20) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Dieu Hanh Vien 20', 'DH020', DATE '1998-01-01', 'Nu', 'Hoi Sinh Vien', 'BCH', '0909876520', 'TP.HCM');

    -- 3. TAI KHOAN TINH NGUYEN VIEN (50 User)
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520001', '123456', '22520001@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(1) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 1', '22520001', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000001', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520002', '123456', '22520002@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(2) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 2', '22520002', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000002', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520003', '123456', '22520003@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(3) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 3', '22520003', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000003', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520004', '123456', '22520004@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(4) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 4', '22520004', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000004', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520005', '123456', '22520005@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(5) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 5', '22520005', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000005', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520006', '123456', '22520006@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(6) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 6', '22520006', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000006', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520007', '123456', '22520007@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(7) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 7', '22520007', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000007', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520008', '123456', '22520008@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(8) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 8', '22520008', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000008', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520009', '123456', '22520009@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(9) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 9', '22520009', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000009', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520010', '123456', '22520010@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(10) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 10', '22520010', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000010', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520011', '123456', '22520011@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(11) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 11', '22520011', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000011', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520012', '123456', '22520012@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(12) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 12', '22520012', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000012', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520013', '123456', '22520013@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(13) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 13', '22520013', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000013', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520014', '123456', '22520014@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(14) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 14', '22520014', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000014', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520015', '123456', '22520015@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(15) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 15', '22520015', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000015', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520016', '123456', '22520016@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(16) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 16', '22520016', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000016', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520017', '123456', '22520017@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(17) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 17', '22520017', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000017', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520018', '123456', '22520018@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(18) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 18', '22520018', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000018', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520019', '123456', '22520019@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(19) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 19', '22520019', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000019', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520020', '123456', '22520020@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(20) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 20', '22520020', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000020', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520021', '123456', '22520021@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(21) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 21', '22520021', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000021', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520022', '123456', '22520022@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(22) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 22', '22520022', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000022', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520023', '123456', '22520023@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(23) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 23', '22520023', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000023', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520024', '123456', '22520024@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(24) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 24', '22520024', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000024', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520025', '123456', '22520025@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(25) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 25', '22520025', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000025', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520026', '123456', '22520026@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(26) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 26', '22520026', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000026', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520027', '123456', '22520027@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(27) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 27', '22520027', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000027', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520028', '123456', '22520028@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(28) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 28', '22520028', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000028', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520029', '123456', '22520029@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(29) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 29', '22520029', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000029', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520030', '123456', '22520030@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(30) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 30', '22520030', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000030', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520031', '123456', '22520031@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(31) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 31', '22520031', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000031', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520032', '123456', '22520032@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(32) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 32', '22520032', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000032', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520033', '123456', '22520033@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(33) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 33', '22520033', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000033', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520034', '123456', '22520034@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(34) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 34', '22520034', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000034', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520035', '123456', '22520035@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(35) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 35', '22520035', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000035', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520036', '123456', '22520036@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(36) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 36', '22520036', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000036', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520037', '123456', '22520037@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(37) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 37', '22520037', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000037', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520038', '123456', '22520038@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(38) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 38', '22520038', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000038', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520039', '123456', '22520039@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(39) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 39', '22520039', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000039', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520040', '123456', '22520040@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(40) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 40', '22520040', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000040', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520041', '123456', '22520041@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(41) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 41', '22520041', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000041', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520042', '123456', '22520042@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(42) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 42', '22520042', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000042', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520043', '123456', '22520043@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(43) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 43', '22520043', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000043', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520044', '123456', '22520044@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(44) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 44', '22520044', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000044', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520045', '123456', '22520045@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(45) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 45', '22520045', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000045', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520046', '123456', '22520046@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(46) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 46', '22520046', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000046', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520047', '123456', '22520047@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(47) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 47', '22520047', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000047', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520048', '123456', '22520048@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(48) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 48', '22520048', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000048', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520049', '123456', '22520049@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(49) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 49', '22520049', DATE '2004-05-15', 'Nu', 'Khoa CNTT', 'KTPM2022', '0988000049', 'KTX Khu A, DHQG-HCM');
    INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Email, VaiTro, TrangThai) VALUES ('22520050', '123456', '22520050@gm.uit.edu.vn', 'TinhNguyenVien', 'HoatDong') RETURNING MaTaiKhoan INTO v_tmp;
    v_tk_tnv(50) := v_tmp;
    INSERT INTO HoSoSinhVien(MaTaiKhoan, HoTen, MSSV, NgaySinh, GioiTinh, Khoa, Lop, SoDienThoai, DiaChi) VALUES (v_tmp, 'Sinh Vien Thu 50', '22520050', DATE '2004-05-15', 'Nam', 'Khoa CNTT', 'KTPM2022', '0988000050', 'KTX Khu A, DHQG-HCM');

    -- 4. DOI TAC (5 Doi Tac)
    INSERT INTO DoiTac(TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi) VALUES ('Há»™i Sinh viÃªn ÄHQG-HCM', 'Quáº£n lÃ½ tá»• chá»©c', '02838647256', 'hsv@vnuhcm.edu.vn', 'PhÆ°á»ng Linh Trung, TP. Thá»§ Äá»©c') RETURNING MaDoiTac INTO v_tmp;
    v_dt_ids(1) := v_tmp;
    INSERT INTO DoiTac(TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi) VALUES ('NgÃ¢n hÃ ng Agribank Chi nhÃ¡nh ÄÃ´ng SG', 'TÃ i trá»£ tÃ i chÃ­nh', '02838960123', 'dongsg@agribank.com.vn', 'TP. Thá»§ Äá»©c, TP.HCM') RETURNING MaDoiTac INTO v_tmp;
    v_dt_ids(2) := v_tmp;
    INSERT INTO DoiTac(TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi) VALUES ('CÃ´ng ty Cá»• pháº§n Sá»¯a Vinamilk', 'TÃ i trá»£ nhu yáº¿u pháº©m', '02854155555', 'cskh@vinamilk.com.vn', 'Quáº­n 7, TP.HCM') RETURNING MaDoiTac INTO v_tmp;
    v_dt_ids(3) := v_tmp;
    INSERT INTO DoiTac(TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi) VALUES ('NhÃ  vÄƒn hÃ³a Sinh viÃªn TP.HCM', 'CÆ¡ sá»Ÿ váº­t cháº¥t', '02838224382', 'lienhe@nvhsv.org.vn', 'Khu Ä‘Ã´ thá»‹ ÄHQG-HCM') RETURNING MaDoiTac INTO v_tmp;
    v_dt_ids(4) := v_tmp;
    INSERT INTO DoiTac(TenDoiTac, LinhVuc, SoDienThoai, Email, DiaChi) VALUES ('Bá»‡nh viá»‡n Chá»£ Ráº«y', 'Y táº¿', '02838554137', 'bvchoray@choray.vn', 'Quáº­n 5, TP.HCM') RETURNING MaDoiTac INTO v_tmp;
    v_dt_ids(5) := v_tmp;

    -- 5. LOAI VAT PHAM (10 Loai)
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Ão MÃ¹a HÃ¨ Xanh', 'CÃ¡i', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(1) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Ão Tiáº¿p Sá»©c MÃ¹a Thi', 'CÃ¡i', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(2) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('NÃ³n tai bÃ¨o', 'CÃ¡i', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(3) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('NÆ°á»›c suá»‘i Ä‘Ã³ng chai', 'ThÃ¹ng', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(4) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Sá»¯a há»™p', 'ThÃ¹ng', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(5) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('MÃ¬ tÃ´m', 'ThÃ¹ng', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(6) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Cuá»‘c xáº»ng', 'CÃ¡i', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(7) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('SÃ¡ch vá»Ÿ há»c sinh', 'Bá»™', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(8) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Thuá»‘c men cÆ¡ báº£n', 'Há»™p', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(9) := v_tmp;
    INSERT INTO LoaiVatPham(TenLoai, DonViTinh, SoLuongTon) VALUES ('Ão áº¥m', 'CÃ¡i', 0) RETURNING MaLoai INTO v_tmp;
    v_loai_ids(10) := v_tmp;

    -- 6. CHIEN DICH (20 Chien Dich map 1-1 voi Ban Dieu Hanh)
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('XuÃ¢n TÃ¬nh Nguyá»‡n 2024 - KTX ÄHQG-HCM', DATE '2024-01-05', DATE '2024-02-05', 'Mang khÃ´ng khÃ­ xuÃ¢n Ä‘áº¿n vá»›i cÃ¡c báº¡n sinh viÃªn xa nhÃ  táº¡i KÃ½ tÃºc xÃ¡ ÄHQG-HCM.', 150, 20000000, 'DaKetThuc', v_tk_dieuhanh(1), NULL) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(1) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(1), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-01-05');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(1) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(2) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong XuÃ¢n TÃ¬nh Nguyá»‡n 2024 - KTX ÄHQG-HCM', 'Noi dung phat dong...', v_tk_dieuhanh(1));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('XuÃ¢n TÃ¬nh Nguyá»‡n 2024 - MÃ¡i áº¥m tÃ¬nh thÆ°Æ¡ng', DATE '2024-01-10', DATE '2024-02-08', 'ChÄƒm lo táº¿t cho tráº» em má»“ cÃ´i táº¡i cÃ¡c mÃ¡i áº¥m trÃªn Ä‘á»‹a bÃ n TP.Thá»§ Äá»©c.', 50, 15000000, 'DaKetThuc', v_tk_dieuhanh(2), NULL) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(2) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(2), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-01-10');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(3) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(4) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong XuÃ¢n TÃ¬nh Nguyá»‡n 2024 - MÃ¡i áº¥m tÃ¬nh thÆ°Æ¡ng', 'Noi dung phat dong...', v_tk_dieuhanh(2));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n tá»‰nh Báº¿n Tre', DATE '2024-07-01', DATE '2024-08-01', 'XÃ¢y dá»±ng cáº§u Ä‘Æ°á»ng nÃ´ng thÃ´n, tháº¯p sÃ¡ng Ä‘Æ°á»ng quÃª vÃ  dáº¡y há»c cho tráº» em táº¡i Báº¿n Tre.', 300, 100000000, 'DaKetThuc', v_tk_dieuhanh(3), 60) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(3) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(3), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-07-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(5) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(6) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n tá»‰nh Báº¿n Tre', 'Noi dung phat dong...', v_tk_dieuhanh(3));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n TP.HCM', DATE '2024-07-05', DATE '2024-08-05', 'Dá»n dáº¹p vá»‡ sinh kÃªnh ráº¡ch, tuyÃªn truyá»n phÃ²ng chá»‘ng dá»‹ch bá»‡nh táº¡i cÃ¡c quáº­n ven.', 500, 50000000, 'DaKetThuc', v_tk_dieuhanh(4), 40) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(4) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(4), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-07-05');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(7) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(8) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n TP.HCM', 'Noi dung phat dong...', v_tk_dieuhanh(4));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n Äáº¯k NÃ´ng', DATE '2024-07-10', DATE '2024-08-10', 'Há»— trá»£ bÃ  con dÃ¢n tá»™c thiá»ƒu sá»‘ phÃ¡t triá»ƒn kinh táº¿, xÃ¢y dá»±ng nhÃ  tÃ¬nh thÆ°Æ¡ng.', 100, 150000000, 'DaKetThuc', v_tk_dieuhanh(5), 80) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(5) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(5), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-07-10');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(9) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(10) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong MÃ¹a HÃ¨ Xanh 2024 - Máº·t tráº­n Äáº¯k NÃ´ng', 'Noi dung phat dong...', v_tk_dieuhanh(5));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Tiáº¿p Sá»©c MÃ¹a Thi 2024 - Cá»¥m thi ÄHQG', DATE '2024-06-25', DATE '2024-07-05', 'Há»— trá»£ thÃ­ sinh tham gia ká»³ thi THPT Quá»‘c gia táº¡i cá»¥m thi LÃ ng Äáº¡i Há»c.', 800, 20000000, 'DaKetThuc', v_tk_dieuhanh(6), 15) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(6) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(6), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-06-25');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(11) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(12) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Tiáº¿p Sá»©c MÃ¹a Thi 2024 - Cá»¥m thi ÄHQG', 'Noi dung phat dong...', v_tk_dieuhanh(6));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Chá»§ Nháº­t Xanh Ä‘á»£t 1 - XÃ¢y dá»±ng KhÃ´ng gian xanh', DATE '2024-03-10', DATE '2024-03-10', 'Dá»n dáº¹p rÃ¡c tháº£i vÃ  trá»“ng cÃ¢y xanh quanh khu vá»±c há»“ ÄÃ¡ vÃ  LÃ ng Äáº¡i Há»c.', 200, 5000000, 'DaKetThuc', v_tk_dieuhanh(7), 4) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(7) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(7), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-03-10');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(13) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(14) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Chá»§ Nháº­t Xanh Ä‘á»£t 1 - XÃ¢y dá»±ng KhÃ´ng gian xanh', 'Noi dung phat dong...', v_tk_dieuhanh(7));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('NgÃ y há»™i Hiáº¿n MÃ¡u TÃ¬nh Nguyá»‡n Ä‘á»£t 1/2024', DATE '2024-04-15', DATE '2024-04-15', 'Hiáº¿n mÃ¡u cá»©u ngÆ°á»i táº¡i NhÃ  Ä‘iá»u hÃ nh ÄHQG-HCM.', 1000, 10000000, 'DaKetThuc', v_tk_dieuhanh(8), 4) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(8) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(8), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-04-15');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(15) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(16) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong NgÃ y há»™i Hiáº¿n MÃ¡u TÃ¬nh Nguyá»‡n Ä‘á»£t 1/2024', 'Noi dung phat dong...', v_tk_dieuhanh(8));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Chiáº¿n dá»‹ch TÃ¬nh nguyá»‡n Ká»³ Nghá»‰ Há»“ng 2024', DATE '2024-08-15', DATE '2024-09-15', 'Chiáº¿n dá»‹ch dÃ nh cho cÃ¡n bá»™ viÃªn chá»©c tráº» há»— trá»£ chuyÃªn mÃ´n cho Ä‘á»‹a phÆ°Æ¡ng.', 50, 30000000, 'DaKetThuc', v_tk_dieuhanh(9), 20) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(9) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(9), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-08-15');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(17) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(18) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Chiáº¿n dá»‹ch TÃ¬nh nguyá»‡n Ká»³ Nghá»‰ Há»“ng 2024', 'Noi dung phat dong...', v_tk_dieuhanh(9));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('LÃ² luyá»‡n thi Äáº¡i há»c Miá»…n PhÃ­ 2024', DATE '2024-03-01', DATE '2024-06-30', 'Sinh viÃªn xuáº¥t sáº¯c tham gia dáº¡y kÃ¨m miá»…n phÃ­ cho há»c sinh hoÃ n cáº£nh khÃ³ khÄƒn.', 150, 10000000, 'DaKetThuc', v_tk_dieuhanh(10), 100) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(10) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(10), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-03-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(19) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(20) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong LÃ² luyá»‡n thi Äáº¡i há»c Miá»…n PhÃ­ 2024', 'Noi dung phat dong...', v_tk_dieuhanh(10));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Vui Táº¿t Trung Thu 2024 - Ná»¥ cÆ°á»i tráº» thÆ¡', DATE '2024-09-15', DATE '2024-09-17', 'Tá»• chá»©c rÆ°á»›c Ä‘Ã¨n, phÃ¡t quÃ  cho tráº» em cÃ³ hoÃ n cáº£nh khÃ³ khÄƒn táº¡i BÃ¬nh DÆ°Æ¡ng.', 100, 25000000, 'DaKetThuc', v_tk_dieuhanh(11), 8) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(11) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(11), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-09-15');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(21) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(22) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Vui Táº¿t Trung Thu 2024 - Ná»¥ cÆ°á»i tráº» thÆ¡', 'Noi dung phat dong...', v_tk_dieuhanh(11));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Ão áº¥m mÃ¹a Ä‘Ã´ng - SÆ°á»Ÿi áº¥m vÃ¹ng cao', DATE '2024-11-01', DATE '2024-12-15', 'QuyÃªn gÃ³p quáº§n Ã¡o áº¥m vÃ  nhu yáº¿u pháº©m gá»­i táº·ng Ä‘á»“ng bÃ o vÃ¹ng cao HÃ  Giang.', 80, 50000000, 'DaKetThuc', v_tk_dieuhanh(12), 20) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(12) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(12), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-11-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(23) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(24) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Ão áº¥m mÃ¹a Ä‘Ã´ng - SÆ°á»Ÿi áº¥m vÃ¹ng cao', 'Noi dung phat dong...', v_tk_dieuhanh(12));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Äá»•i RÃ¡c Láº¥y QuÃ  - VÃ¬ mÃ´i trÆ°á»ng xanh 2024', DATE '2024-10-10', DATE '2024-10-12', 'Thu gom giáº¥y bÃ¡o, chai nhá»±a Ä‘á»•i láº¥y sen Ä‘Ã¡ vÃ  tÃºi váº£i thÃ¢n thiá»‡n mÃ´i trÆ°á»ng.', 120, 8000000, 'DaKetThuc', v_tk_dieuhanh(13), 6) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(13) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(13), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-10-10');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(25) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(26) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Äá»•i RÃ¡c Láº¥y QuÃ  - VÃ¬ mÃ´i trÆ°á»ng xanh 2024', 'Noi dung phat dong...', v_tk_dieuhanh(13));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('TÃ¬nh Nguyá»‡n Quá»‘c Táº¿ - Giao lÆ°u ASEAN', DATE '2024-12-01', DATE '2024-12-10', 'Giao lÆ°u vÄƒn hÃ³a vÃ  thá»±c hiá»‡n dá»± Ã¡n mÃ´i trÆ°á»ng cÃ¹ng sinh viÃªn cÃ¡c nÆ°á»›c ASEAN.', 40, 100000000, 'DaKetThuc', v_tk_dieuhanh(14), 40) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(14) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(14), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-12-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(27) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(28) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong TÃ¬nh Nguyá»‡n Quá»‘c Táº¿ - Giao lÆ°u ASEAN', 'Noi dung phat dong...', v_tk_dieuhanh(14));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Há»— trá»£ chuyá»ƒn Ä‘á»•i sá»‘ cho ngÆ°á»i dÃ¢n', DATE '2024-05-01', DATE '2024-05-30', 'Sinh viÃªn khá»‘i CNTT hÆ°á»›ng dáº«n ngÆ°á»i dÃ¢n sá»­ dá»¥ng dá»‹ch vá»¥ cÃ´ng trá»±c tuyáº¿n.', 200, 10000000, 'DaKetThuc', v_tk_dieuhanh(15), 25) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(15) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(15), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-05-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(29) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(30) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Há»— trá»£ chuyá»ƒn Ä‘á»•i sá»‘ cho ngÆ°á»i dÃ¢n', 'Noi dung phat dong...', v_tk_dieuhanh(15));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Kháº¯c phá»¥c háº­u quáº£ bÃ£o lÅ© miá»n Trung', DATE '2024-10-20', DATE '2024-11-20', 'Huy Ä‘á»™ng nguá»“n lá»±c vÃ  nhÃ¢n lá»±c há»— trá»£ Ä‘á»“ng bÃ o miá»n Trung bá»‹ áº£nh hÆ°á»Ÿng bÃ£o.', 300, 500000000, 'DaKetThuc', v_tk_dieuhanh(16), 50) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(16) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(16), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(1), 'DaDuyet', DATE '2024-10-20');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(31) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(32) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Kháº¯c phá»¥c háº­u quáº£ bÃ£o lÅ© miá»n Trung', 'Noi dung phat dong...', v_tk_dieuhanh(16));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('XÃ¢y cáº§u giao thÃ´ng nÃ´ng thÃ´n táº¡i Äá»“ng ThÃ¡p', DATE '2024-02-01', DATE '2024-03-01', 'GÃ³p sá»©c tráº» xÃ¢y cáº§u bÃªtÃ´ng thay tháº¿ cáº§u khá»‰ táº¡i huyá»‡n Lai Vung.', 60, 250000000, 'DaKetThuc', v_tk_dieuhanh(17), 60) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(17) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(17), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2024-02-01');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(33) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(34) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong XÃ¢y cáº§u giao thÃ´ng nÃ´ng thÃ´n táº¡i Äá»“ng ThÃ¡p', 'Noi dung phat dong...', v_tk_dieuhanh(17));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('XuÃ¢n TÃ¬nh Nguyá»‡n 2025 - Káº¿t ná»‘i cá»™ng Ä‘á»“ng', DATE '2025-01-05', DATE '2025-02-05', 'Tiáº¿p ná»‘i tinh tháº§n xung kÃ­ch chÄƒm lo Táº¿t cho cÃ¡c hoÃ n cáº£nh khÃ³ khÄƒn.', 200, 30000000, 'DangHoatDong', v_tk_dieuhanh(18), NULL) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(18) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(18), v_tmp);
    INSERT INTO DuyetChienDich(MaChienDich, MaNguoiDuyet, TrangThai, NgayDuyet) VALUES (v_tmp, v_tk_admin(2), 'DaDuyet', DATE '2025-01-05');
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(35) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(36) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong XuÃ¢n TÃ¬nh Nguyá»‡n 2025 - Káº¿t ná»‘i cá»™ng Ä‘á»“ng', 'Noi dung phat dong...', v_tk_dieuhanh(18));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('Tiáº¿p Sá»©c MÃ¹a Thi 2025 - Äá»“ng hÃ nh sÄ© tá»­', DATE '2025-06-25', DATE '2025-07-05', 'Há»— trá»£ sÄ© tá»­ trong ká»³ thi tá»‘t nghiá»‡p THPT 2025.', 800, 25000000, 'ChoDuyet', v_tk_dieuhanh(19), 15) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(19) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(19), v_tmp);
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(37) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(38) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong Tiáº¿p Sá»©c MÃ¹a Thi 2025 - Äá»“ng hÃ nh sÄ© tá»­', 'Noi dung phat dong...', v_tk_dieuhanh(19));
    INSERT INTO ChienDich(TenChienDich, NgayBatDau, NgayKetThuc, MoTa, SoLuongTNVToiDa, MucTieuTien, TrangThai, MaNguoiTao, GioToiThieuCN) VALUES ('NgÃ y há»™i Hiáº¿n MÃ¡u TÃ¬nh Nguyá»‡n Ä‘á»£t 1/2025', DATE '2025-04-10', DATE '2025-04-10', 'Chung tay vÃ¬ cá»™ng Ä‘á»“ng, hiáº¿n giá»t mÃ¡u Ä‘Ã o trao Ä‘á»i sá»± sá»‘ng.', 1000, 15000000, 'ChoDuyet', v_tk_dieuhanh(20), 4) RETURNING MaChienDich INTO v_tmp;
    v_cd_ids(20) := v_tmp;
    INSERT INTO BanDieuHanh(MaTaiKhoan, MaChienDich) VALUES (v_tk_dieuhanh(20), v_tmp);
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban truyen thong', 20) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(39) := v_tmp2;
    INSERT INTO CongViec(MaChienDich, TenCongViec, SoLuongTNVCan) VALUES (v_tmp, 'Ban hau can', 30) RETURNING MaCongViec INTO v_tmp2;
    v_cv_ids(40) := v_tmp2;
    INSERT INTO TinTuc(MaChienDich, TieuDe, NoiDung, MaNguoiDang) VALUES (v_tmp, 'Phat dong NgÃ y há»™i Hiáº¿n MÃ¡u TÃ¬nh Nguyá»‡n Ä‘á»£t 1/2025', 'Noi dung phat dong...', v_tk_dieuhanh(20));

    -- 7. THAM GIA TNV & PHAN CONG & DIEM DANH
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(39), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(1) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(1) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(2) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(2) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(3) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(2), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(3) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 17);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(49), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(4) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(2), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(4) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 44);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(12), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(5) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(2), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(5) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(32), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(6) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(6) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 54);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(7) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(7) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 56);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(26), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(8) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(8) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 37);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(9) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(2), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(9) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 49);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(20), v_cd_ids(1), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(10) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(1), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(10) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-05', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(44), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(11) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(11) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 45);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(37), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(12) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(12) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 33);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(41), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(13) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(13) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 14);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(48), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(14) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(3), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(14) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(15) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(15) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 16);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(39), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(16) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(16) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(3), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(17) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(3), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(17) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(14), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(18) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(3), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(18) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 40);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(20), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(19) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(3), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(19) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 60);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(15), v_cd_ids(2), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(20) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(4), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(20) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-01-10', 'CoMat', 20);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(21) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(21) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(33), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(22) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(5), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(22) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 13);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(43), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(23) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(23) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(1), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(24) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(5), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(24) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 24);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(4), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(25) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(25) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(26) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(26) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 24);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(38), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(27) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(27) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 52);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(22), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(28) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(5), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(28) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 48);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(45), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(29) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(6), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(29) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 55);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(46), v_cd_ids(3), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(30) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(5), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(30) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-01', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(48), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(31) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(31) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 28);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(32) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(32) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 34);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(24), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(33) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(33) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(25), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(34) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(34) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 46);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(50), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(35) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(35) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(36) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(36) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(21), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(37) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(7), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(37) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 24);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(37), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(38) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(38) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 42);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(8), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(39) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(7), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(39) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 52);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(4), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(40) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(8), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(40) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-05', 'CoMat', 60);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(25), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(41) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(9), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(41) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 18);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(42) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(42) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 18);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(6), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(43) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(9), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(43) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(26), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(44) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(9), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(44) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(45) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(45) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(32), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(46) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(46) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 22);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(45), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(47) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(47) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 43);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(28), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(48) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(48) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(19), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(49) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(9), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(49) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 43);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(24), v_cd_ids(5), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(50) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(10), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(50) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-07-10', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(51) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(51) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 52);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(38), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(52) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(52) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(2), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(53) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(53) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 44);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(34), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(54) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(54) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(12), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(55) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(55) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 45);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(56) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(11), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(56) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 40);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(21), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(57) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(12), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(57) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(50), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(58) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(11), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(58) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 19);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(32), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(59) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(11), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(59) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(11), v_cd_ids(6), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(60) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(11), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(60) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-06-25', 'CoMat', 58);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(17), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(61) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(61) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(22), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(62) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(62) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 37);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(43), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(63) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(63) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(64) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(64) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 37);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(3), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(65) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(13), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(65) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 25);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(66) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(13), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(66) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 17);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(44), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(67) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(13), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(67) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 28);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(5), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(68) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(68) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 38);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(69) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(13), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(69) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 31);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(7), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(70) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(14), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(70) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-10', 'CoMat', 13);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(35), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(71) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(71) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(28), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(72) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(72) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(14), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(73) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(73) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(34), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(74) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(74) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 51);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(9), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(75) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(75) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(76) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(15), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(76) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 30);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(5), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(77) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(16), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(77) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 24);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(37), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(78) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(16), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(78) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 43);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(79) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(16), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(79) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(40), v_cd_ids(8), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(80) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(16), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(80) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-04-15', 'CoMat', 30);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(32), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(81) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(18), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(81) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 20);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(38), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(82) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(18), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(82) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 56);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(48), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(83) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(18), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(83) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(28), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(84) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(84) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 49);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(13), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(85) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(85) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 46);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(41), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(86) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(86) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 56);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(37), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(87) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(87) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 37);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(19), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(88) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(18), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(88) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(14), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(89) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(89) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(8), v_cd_ids(9), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(90) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(17), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(90) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-08-15', 'CoMat', 31);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(40), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(91) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(91) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 29);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(41), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(92) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(20), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(92) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 47);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(44), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(93) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(93) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 40);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(15), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(94) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(94) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 42);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(49), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(95) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(95) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(25), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(96) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(20), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(96) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 14);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(97) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(20), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(97) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 19);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(1), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(98) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(98) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 38);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(34), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(99) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(99) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 58);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(31), v_cd_ids(10), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(100) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(19), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(100) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-03-01', 'CoMat', 26);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(101) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(101) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 11);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(11), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(102) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(102) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 35);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(41), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(103) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(103) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 56);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(104) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(104) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 22);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(21), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(105) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(105) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 46);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(39), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(106) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(106) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 53);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(107) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(107) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 25);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(1), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(108) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(22), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(108) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 22);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(32), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(109) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(21), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(109) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 15);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(4), v_cd_ids(11), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(110) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(22), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(110) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-09-15', 'CoMat', 32);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(111) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(23), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(111) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 32);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(112) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(24), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(112) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 31);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(12), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(113) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(24), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(113) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 30);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(40), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(114) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(24), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(114) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 18);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(21), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(115) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(23), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(115) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 12);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(4), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(116) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(23), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(116) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 13);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(5), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(117) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(24), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(117) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 48);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(118) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(24), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(118) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 19);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(9), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(119) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(23), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(119) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(12), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(120) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(23), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(120) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-11-01', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(17), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(121) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(26), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(121) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 44);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(45), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(122) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(26), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(122) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 35);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(35), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(123) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(25), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(123) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(38), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(124) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(26), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(124) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 46);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(8), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(125) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(26), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(125) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 48);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(24), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(126) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(26), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(126) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 38);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(6), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(127) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(25), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(127) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 18);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(23), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(128) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(25), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(128) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(11), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(129) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(25), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(129) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 30);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(13), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(130) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(25), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(130) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-10', 'CoMat', 59);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(50), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(131) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(27), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(131) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 33);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(17), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(132) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(27), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(132) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 25);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(7), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(133) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(27), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(133) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 24);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(39), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(134) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(27), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(134) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 16);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(3), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(135) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(27), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(135) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 27);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(5), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(136) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(28), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(136) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 59);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(48), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(137) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(28), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(137) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(14), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(138) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(28), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(138) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(139) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(28), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(139) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 44);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(10), v_cd_ids(14), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(140) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(28), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(140) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-12-01', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(35), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(141) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(30), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(141) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 25);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(45), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(142) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(142) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 59);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(6), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(143) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(30), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(143) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 49);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(34), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(144) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(144) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 50);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(38), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(145) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(145) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 34);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(2), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(146) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(30), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(146) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 39);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(147) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(147) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 46);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(50), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(148) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(148) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 49);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(33), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(149) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(30), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(149) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(9), v_cd_ids(15), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(150) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(29), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(150) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-05-01', 'CoMat', 10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(46), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(151) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(151) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 42);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(152) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(31), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(152) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 32);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(12), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(153) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(153) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 48);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(154) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(31), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(154) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 41);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(44), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(155) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(155) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 29);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(18), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(156) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(156) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 10);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(42), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(157) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(31), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(157) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(17), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(158) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(158) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 16);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(23), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(159) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(32), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(159) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 34);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(5), v_cd_ids(16), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(160) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(31), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(160) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-10-20', 'CoMat', 44);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(40), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(161) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(161) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(21), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(162) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(33), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(162) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 52);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(163) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(163) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 22);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(41), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(164) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(164) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 32);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(165) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(165) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 27);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(18), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(166) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(33), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(166) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 13);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(25), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(167) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(33), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(167) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 32);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(33), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(168) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(168) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 38);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(49), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(169) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(34), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(169) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 35);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(17), 'HoanThanh') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(170) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(33), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(170) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2024-02-01', 'CoMat', 14);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(171) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(171) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 21);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(17), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(172) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(172) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 43);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(49), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(173) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(173) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 11);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(28), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(174) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(174) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 53);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(42), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(175) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(35), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(175) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 26);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(22), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(176) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(176) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 38);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(12), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(177) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(35), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(177) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 36);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(15), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(178) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(35), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(178) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 57);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(9), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(179) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(35), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(179) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 19);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(18), 'DaDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(180) := v_tmp;
    INSERT INTO PhanCong(MaThamGia, MaCongViec, TrangThai) VALUES (v_tmp, v_cv_ids(36), 'DangThucHien') RETURNING MaPhanCong INTO v_tmp2;
    v_pc_ids(180) := v_tmp2;
    INSERT INTO DiemDanh(MaThamGia, NgayDiemDanh, TrangThai, SoGioGhiNhan) VALUES (v_tmp, DATE '2025-01-05', 'CoMat', 11);
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(18), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(181) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(36), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(182) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(13), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(183) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(11), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(184) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(49), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(185) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(26), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(186) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(187) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(188) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(47), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(189) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(14), v_cd_ids(19), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(190) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(45), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(191) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(23), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(192) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(16), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(193) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(26), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(194) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(33), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(195) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(25), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(196) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(29), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(197) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(6), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(198) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(30), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(199) := v_tmp;
    INSERT INTO ThamGiaTNV(MaTaiKhoan, MaChienDich, TrangThaiDuyet) VALUES (v_tk_tnv(27), v_cd_ids(20), 'ChoDuyet') RETURNING MaThamGia INTO v_tmp;
    v_tg_ids(200) := v_tmp;

    -- 8. CAP CHUNG NHAN (Qua SP_CAP_CHUNGNHAN_CD)
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(1));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(2));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(3));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(4));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(5));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(6));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(7));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(8));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(9));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(10));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(11));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(12));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(13));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(14));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(15));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(16));
    SP_CAP_CHUNGNHAN_CD(v_cd_ids(17));

    -- 9. QUYEN GOP & THANH TOAN
    INSERT INTO QuyenGopTien(MaTaiKhoan, MaChienDich, SoTien, PhuongThuc) VALUES (v_tk_tnv(1), v_cd_ids(1), 500000, 'ChuyenKhoan') RETURNING MaQuyenGop INTO v_tmp;
    INSERT INTO ThanhToan(MaQuyenGop, TrangThaiThanhToan) VALUES (v_tmp, 'ThanhCong');
    INSERT INTO TaiTro(MaDoiTac, MaChienDich, GiaTriTaiTro, NgayTaiTro) VALUES (v_dt_ids(1), v_cd_ids(1), 10000000, SYSDATE);
    INSERT INTO QuyenGopTien(MaTaiKhoan, MaChienDich, SoTien, PhuongThuc) VALUES (v_tk_tnv(1), v_cd_ids(2), 500000, 'ChuyenKhoan') RETURNING MaQuyenGop INTO v_tmp;
    INSERT INTO ThanhToan(MaQuyenGop, TrangThaiThanhToan) VALUES (v_tmp, 'ThanhCong');
    INSERT INTO TaiTro(MaDoiTac, MaChienDich, GiaTriTaiTro, NgayTaiTro) VALUES (v_dt_ids(1), v_cd_ids(2), 10000000, SYSDATE);
    INSERT INTO QuyenGopTien(MaTaiKhoan, MaChienDich, SoTien, PhuongThuc) VALUES (v_tk_tnv(1), v_cd_ids(3), 500000, 'ChuyenKhoan') RETURNING MaQuyenGop INTO v_tmp;
    INSERT INTO ThanhToan(MaQuyenGop, TrangThaiThanhToan) VALUES (v_tmp, 'ThanhCong');
    INSERT INTO TaiTro(MaDoiTac, MaChienDich, GiaTriTaiTro, NgayTaiTro) VALUES (v_dt_ids(1), v_cd_ids(3), 10000000, SYSDATE);
    INSERT INTO QuyenGopTien(MaTaiKhoan, MaChienDich, SoTien, PhuongThuc) VALUES (v_tk_tnv(1), v_cd_ids(4), 500000, 'ChuyenKhoan') RETURNING MaQuyenGop INTO v_tmp;
    INSERT INTO ThanhToan(MaQuyenGop, TrangThaiThanhToan) VALUES (v_tmp, 'ThanhCong');
    INSERT INTO TaiTro(MaDoiTac, MaChienDich, GiaTriTaiTro, NgayTaiTro) VALUES (v_dt_ids(1), v_cd_ids(4), 10000000, SYSDATE);
    INSERT INTO QuyenGopTien(MaTaiKhoan, MaChienDich, SoTien, PhuongThuc) VALUES (v_tk_tnv(1), v_cd_ids(5), 500000, 'ChuyenKhoan') RETURNING MaQuyenGop INTO v_tmp;
    INSERT INTO ThanhToan(MaQuyenGop, TrangThaiThanhToan) VALUES (v_tmp, 'ThanhCong');
    INSERT INTO TaiTro(MaDoiTac, MaChienDich, GiaTriTaiTro, NgayTaiTro) VALUES (v_dt_ids(1), v_cd_ids(5), 10000000, SYSDATE);

    -- 10. KHO VAT PHAM (Nhap Xuat)
    SP_NHAPKHO_VATPHAM(v_cd_ids(1), v_loai_ids(1), 100);
    SP_NHAPKHO_VATPHAM(v_cd_ids(1), v_loai_ids(2), 200);
    SP_XUATKHO_VATPHAM(v_cd_ids(1), v_loai_ids(1), 50, 'Sinh Vien A');
    SP_NHAPKHO_VATPHAM(v_cd_ids(2), v_loai_ids(1), 100);
    SP_NHAPKHO_VATPHAM(v_cd_ids(2), v_loai_ids(2), 200);
    SP_XUATKHO_VATPHAM(v_cd_ids(2), v_loai_ids(1), 50, 'Sinh Vien A');
    SP_NHAPKHO_VATPHAM(v_cd_ids(3), v_loai_ids(1), 100);
    SP_NHAPKHO_VATPHAM(v_cd_ids(3), v_loai_ids(2), 200);
    SP_XUATKHO_VATPHAM(v_cd_ids(3), v_loai_ids(1), 50, 'Sinh Vien A');

    -- Enable lai cac triggers nghiep vu
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_THOIGIAN ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_TRUNG_LICH ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_KIEMTRA_SOLUONG_DANGKY ENABLE';
    DBMS_OUTPUT.PUT_LINE('>> Da enable lai triggers nghiep vu.');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Tao Seed Data thanh cong voi 3 vai tro: BanQuanLy, BanDieuHanh, TinhNguyenVien!');
END;
/
