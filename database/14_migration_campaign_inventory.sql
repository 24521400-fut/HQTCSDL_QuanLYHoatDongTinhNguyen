-- Create Campaign-specific Inventory Table
CREATE TABLE KhoChienDich (
    MaChienDich VARCHAR2(10) NOT NULL,
    MaLoai      VARCHAR2(10) NOT NULL,
    SoLuongTon  NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT PK_KhoChienDich PRIMARY KEY (MaChienDich, MaLoai),
    CONSTRAINT FK_KhoCD_CD FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich) ON DELETE CASCADE,
    CONSTRAINT FK_KhoCD_Loai FOREIGN KEY (MaLoai) REFERENCES LoaiVatPham(MaLoai) ON DELETE CASCADE,
    CONSTRAINT CHK_KhoCD_SL CHECK (SoLuongTon >= 0)
);

-- (Optional) Initialize KhoChienDich for all existing campaigns and item types
INSERT INTO KhoChienDich (MaChienDich, MaLoai, SoLuongTon)
SELECT cd.MaChienDich, lvp.MaLoai, 0
FROM ChienDich cd, LoaiVatPham lvp;

COMMIT;
