-- ============================================================
-- FILE: 10_migration_evaluation.sql
-- MUC DICH: Tao bang RejectionLogs cho chuc nang tu choi danh gia
-- ============================================================

BEGIN
    FOR t IN (SELECT table_name FROM user_tables WHERE UPPER(table_name) = 'REJECTIONLOGS') LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
    
    FOR s IN (SELECT sequence_name FROM user_sequences WHERE UPPER(sequence_name) = 'S_REJECTION_ID') LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/

-- 1. Tao Sequence
CREATE SEQUENCE s_rejection_id
    MINVALUE 1 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 1
    NOCACHE NOORDER NOCYCLE;

-- 2. Tao Bang RejectionLogs
CREATE TABLE RejectionLogs (
    MaLog       VARCHAR2(10)          NOT NULL,
    MaThamGia   VARCHAR2(10)          NOT NULL,
    LyDo        NVARCHAR2(500)  NOT NULL,
    HinhAnh_URL VARCHAR2(500)   NOT NULL, -- Proof is mandatory
    NgayLog     DATE            DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_RejectionLogs  PRIMARY KEY (MaLog),
    CONSTRAINT FK_Reject_TG      FOREIGN KEY (MaThamGia) REFERENCES ThamGiaTNV(MaThamGia) ON DELETE CASCADE
);

-- 3. Tao Trigger cho MaLog
CREATE OR REPLACE TRIGGER trg_rejection_pk
BEFORE INSERT ON RejectionLogs
FOR EACH ROW
BEGIN
    IF :NEW.MaLog IS NULL THEN
        :NEW.MaLog := 'RL' || LPAD(s_rejection_id.NEXTVAL, 8, '0');
    END IF;
END;
/

COMMIT;
PROMPT >> 10_migration_evaluation.sql: Da tao xong bang RejectionLogs.
