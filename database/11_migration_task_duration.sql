-- ============================================================
-- FILE: 11_migration_task_duration.sql
-- MUC DICH: Them cot ThoiGianKetThuc vao bang CongViec
-- ============================================================

-- 1. Them cot
ALTER TABLE CongViec ADD (ThoiGianKetThuc DATE);

-- 2. Cap nhat du lieu cu tu MoTa (JSON) neu co
-- Luu y: Lenh nay yeu cau Oracle 12c+ ho tro JSON_VALUE
-- Neu khong ho tro, du lieu cu se de NULL va cap nhat thu cong sau
BEGIN
    EXECUTE IMMEDIATE 'UPDATE CongViec SET ThoiGianKetThuc = TO_DATE(JSON_VALUE(MoTa, ''$.endDate''), ''YYYY-MM-DD"T"HH24:MI:SS"Z"'') WHERE MoTa LIKE ''{%''';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Khong the cap nhat tu dong ThoiGianKetThuc tu JSON. Hay cap nhat thu cong.');
END;
/

COMMIT;
PROMPT >> 11_migration_task_duration.sql: Da them cot ThoiGianKetThuc.
