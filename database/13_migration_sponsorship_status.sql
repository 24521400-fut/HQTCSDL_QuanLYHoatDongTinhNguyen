-- Update TaiTro to include Status
ALTER TABLE TaiTro ADD TrangThai VARCHAR2(20) DEFAULT 'ChoDuyet';
ALTER TABLE TaiTro ADD CONSTRAINT CHK_TaiTro_Status CHECK (TrangThai IN ('ChoDuyet', 'DaDuyet', 'TuChoi'));

-- Update PhieuQuyenGopVP to include Status
ALTER TABLE PhieuQuyenGopVP ADD TrangThai VARCHAR2(20) DEFAULT 'ChoDuyet';
ALTER TABLE PhieuQuyenGopVP ADD CONSTRAINT CHK_PQGVP_Status CHECK (TrangThai IN ('ChoDuyet', 'DaDuyet', 'TuChoi'));

-- Add unique constraint to HoSoSinhVien MaTaiKhoan if not already (it is)
-- Done.
