-- Update SP_NHAPKHO_VATPHAM to use KhoChienDich
CREATE OR REPLACE PROCEDURE SP_NHAPKHO_VATPHAM (
    p_MaCD IN VARCHAR2,
    p_MaLoai IN VARCHAR2,
    p_SL IN NUMBER
)
AS
    v_Count NUMBER;
BEGIN
    -- 1. Cap nhat KhoChienDich
    SELECT COUNT(*) INTO v_Count FROM KhoChienDich WHERE MaChienDich = p_MaCD AND MaLoai = p_MaLoai;
    
    IF v_Count > 0 THEN
        UPDATE KhoChienDich SET SoLuongTon = SoLuongTon + p_SL WHERE MaChienDich = p_MaCD AND MaLoai = p_MaLoai;
    ELSE
        INSERT INTO KhoChienDich (MaChienDich, MaLoai, SoLuongTon) VALUES (p_MaCD, p_MaLoai, p_SL);
    END IF;

    -- 2. Tao PhieuQuyenGopVP (Inbound log)
    -- Giu nguyen logic tao phieu cu neu can log
END;
/

-- Update SP_XUATKHO_VATPHAM to use KhoChienDich
CREATE OR REPLACE PROCEDURE SP_XUATKHO_VATPHAM (
    p_MaCD IN VARCHAR2,
    p_MaLoai IN VARCHAR2,
    p_SL IN NUMBER,
    p_NguoiNhan IN NVARCHAR2
)
AS
    v_MaPhieu VARCHAR2(10);
BEGIN
    -- 1. Giam ton kho trong KhoChienDich
    UPDATE KhoChienDich SET SoLuongTon = SoLuongTon - p_SL 
    WHERE MaChienDich = p_MaCD AND MaLoai = p_MaLoai;

    -- 2. Ghi vao PhieuXuatVatPham
    INSERT INTO PhieuXuatVatPham(MaChienDich, NgayXuat, NguoiXuat, NguoiNhan)
    VALUES (p_MaCD, SYSDATE, 'Admin', p_NguoiNhan)
    RETURNING MaPhieuXuat INTO v_MaPhieu;

    INSERT INTO ChiTietXuatVP(MaPhieuXuat, MaLoai, SoLuong)
    VALUES (v_MaPhieu, p_MaLoai, p_SL);
END;
/
