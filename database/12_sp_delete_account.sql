CREATE OR REPLACE PROCEDURE SP_DELETE_ACCOUNT (
    p_MaTK IN VARCHAR2
) AS
BEGIN
    -- 1. Delete TinTuc (News) created by this user
    DELETE FROM TinTuc WHERE MaNguoiDang = p_MaTK;
    
    -- 2. Delete Campaign Approval logs
    DELETE FROM DuyetChienDich WHERE MaNguoiDuyet = p_MaTK;

    -- 3. Delete Campaigns created by this user (Cascades to Work, Assignments, etc.)
    DELETE FROM ChienDich WHERE MaNguoiTao = p_MaTK;

    -- 4. Delete the Account (Cascades to Profile, Notifications, Participations, etc.)
    DELETE FROM TaiKhoan WHERE MaTaiKhoan = p_MaTK;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
