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
    v_NgayBD DATE; v_NgayKT DATE;
    v_TotalHours NUMBER;
    v_MaCD VARCHAR2(10);
    v_DiemXS NUMBER; v_DiemT NUMBER; v_DiemK NUMBER;
BEGIN
    -- 1. Get Score and Campaign info
    SELECT NVL(DiemDanhGia, 0), MaChienDich INTO v_Diem, v_MaCD 
    FROM ThamGiaTNV WHERE MaThamGia = p_MaThamGia;
    
    -- 2. Calculate Total Campaign Hours (24 * days)
    SELECT NgayBatDau, NVL(NgayKetThuc, SYSDATE) INTO v_NgayBD, v_NgayKT 
    FROM ChienDich WHERE MaChienDich = v_MaCD;
    
    v_TotalHours := (v_NgayKT - v_NgayBD + 1) * 24;
    IF v_TotalHours <= 0 THEN v_TotalHours := 24; END IF;

    -- 3. Calculate Total Hours Assigned
    SELECT NVL(SUM(NVL(cv.ThoiGianKetThuc - cv.ThoiGianBatDau, 0) * 24), 0) INTO v_Gio 
    FROM PhanCong pc
    JOIN CongViec cv ON pc.MaCongViec = cv.MaCongViec
    WHERE pc.MaThamGia = p_MaThamGia AND pc.TrangThai != 'HuyBo';
    
    -- 4. Get Score Thresholds from ThamSo
    SELECT TO_NUMBER(GiaTri) INTO v_DiemXS FROM ThamSo WHERE TenThamSo = 'DIEM_XUAT_SAC';
    SELECT TO_NUMBER(GiaTri) INTO v_DiemT FROM ThamSo WHERE TenThamSo = 'DIEM_TOT';
    SELECT TO_NUMBER(GiaTri) INTO v_DiemK FROM ThamSo WHERE TenThamSo = 'DIEM_KHA';
    
    -- 5. Ranking Logic based on % of Campaign Duration
    IF v_Diem >= v_DiemXS AND v_Gio >= (0.8 * v_TotalHours) THEN
        RETURN 'XuatSac';
    ELSIF v_Diem >= v_DiemT AND v_Gio >= (0.7 * v_TotalHours) THEN
        RETURN 'Tot';
    ELSIF v_Diem >= v_DiemK AND v_Gio >= (0.6 * v_TotalHours) THEN
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
