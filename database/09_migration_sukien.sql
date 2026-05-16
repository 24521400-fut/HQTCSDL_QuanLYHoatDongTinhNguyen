-- ============================================================
-- FILE: 09_migration_sukien.sql
-- MUC DICH: Tao sequence, bang va trigger cho chuc nang Su Kien Ca Nhan (TNV Dashboard)
-- ============================================================

-- 1. Xoa doi tuong neu da ton tai (an toan khi chay lai)
BEGIN
    FOR t IN (SELECT table_name FROM user_tables WHERE UPPER(table_name) = 'SUKIENCANHAN') LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
    
    FOR s IN (SELECT sequence_name FROM user_sequences WHERE UPPER(sequence_name) = 'S_SUKIEN_ID') LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/

-- 2. Tao Sequence
CREATE SEQUENCE s_sukien_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

-- 3. Tao Bang SuKienCaNhan
CREATE TABLE SuKienCaNhan (
    MaSuKien    VARCHAR2(10)          NOT NULL,
    MaTaiKhoan  VARCHAR2(10)          NOT NULL,
    TieuDe      NVARCHAR2(255)  NOT NULL,
    ThoiGian    DATE            NOT NULL,
    GhiChu      NVARCHAR2(500),
    CONSTRAINT PK_SuKienCaNhan  PRIMARY KEY (MaSuKien),
    CONSTRAINT FK_SK_TK         FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE
);

-- 4. Tao Trigger de tu dong dien MaSuKien
CREATE OR REPLACE TRIGGER trg_sukien_pk
BEFORE INSERT ON SuKienCaNhan
FOR EACH ROW
BEGIN
    IF :NEW.MaSuKien IS NULL THEN
        :NEW.MaSuKien := 'SK' || TO_CHAR(s_sukien_id.NEXTVAL, 'FM0000000');
    END IF;
END;
/

COMMIT;
PROMPT >> 09_migration_sukien.sql: Da tao xong bang SuKienCaNhan va cac phu thuoc.
