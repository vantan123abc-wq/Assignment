-- ============================================================
-- Cập nhật bảng Orders và Payment để hỗ trợ QR Payment
-- Chạy file này sau khi deploy tính năng thanh toán QR
-- ============================================================

-- ============================================================
-- BẢNG Orders: Xóa CHECK constraint cũ (nếu có) và tạo lại mới
-- ============================================================

-- Tìm và xóa tất cả CHECK constraint trên cột status của bảng Orders
DECLARE @constraintName NVARCHAR(200);
SELECT @constraintName = cc.name
FROM sys.check_constraints cc
JOIN sys.columns c     ON cc.parent_object_id = c.object_id
                       AND cc.parent_column_id = c.column_id
JOIN sys.tables t      ON c.object_id = t.object_id
WHERE t.name = 'Orders' AND c.name = 'status';

IF @constraintName IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Orders DROP CONSTRAINT ' + @constraintName);
    PRINT 'Đã xóa CHECK constraint cũ trên Orders.status: ' + @constraintName;
END
ELSE
BEGIN
    PRINT 'Không có CHECK constraint trên Orders.status — bỏ qua.';
END
GO

-- Thêm CHECK constraint mới cho phép tất cả trạng thái đơn hàng
IF NOT EXISTS (
    SELECT 1 FROM sys.check_constraints cc
    JOIN sys.tables t ON cc.parent_object_id = t.object_id
    WHERE t.name = 'Orders' AND cc.name = 'CHK_Orders_status'
)
BEGIN
    ALTER TABLE Orders
    ADD CONSTRAINT CHK_Orders_status
        CHECK (status IN (
            'PENDING',          -- Đặt hàng COD, chờ xử lý
            'PENDING_PAYMENT',  -- Đặt hàng QR, chờ xác nhận thanh toán
            'CONFIRMED',        -- Admin đã xác nhận
            'SHIPPING',         -- Đang giao hàng
            'DELIVERED',        -- Đã giao thành công
            'CANCELLED'         -- Đã huỷ
        ));
    PRINT 'Đã thêm CHECK constraint mới CHK_Orders_status.';
END
ELSE
BEGIN
    PRINT 'CHK_Orders_status đã tồn tại.';
END
GO

-- ============================================================
-- BẢNG Payment: Xóa CHECK constraint cũ (nếu có) và tạo lại mới
-- ============================================================

DECLARE @payConstraint NVARCHAR(200);
SELECT @payConstraint = cc.name
FROM sys.check_constraints cc
JOIN sys.columns c ON cc.parent_object_id = c.object_id
                   AND cc.parent_column_id = c.column_id
JOIN sys.tables t  ON c.object_id = t.object_id
WHERE t.name = 'Payment' AND c.name = 'method';

IF @payConstraint IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Payment DROP CONSTRAINT ' + @payConstraint);
    PRINT 'Đã xóa CHECK constraint cũ trên Payment.method: ' + @payConstraint;
END
ELSE
BEGIN
    PRINT 'Không có CHECK constraint trên Payment.method — bỏ qua.';
END
GO

-- Thêm CHECK constraint mới cho phép tất cả phương thức thanh toán
IF NOT EXISTS (
    SELECT 1 FROM sys.check_constraints cc
    JOIN sys.tables t ON cc.parent_object_id = t.object_id
    WHERE t.name = 'Payment' AND cc.name = 'CHK_Payment_method'
)
BEGIN
    ALTER TABLE Payment
    ADD CONSTRAINT CHK_Payment_method
        CHECK (method IN (
            'COD',              -- Tiền mặt khi nhận hàng
            'BANK_TRANSFER',    -- Chuyển khoản ngân hàng (QR)
            'MOMO',             -- Ví MoMo (QR)
            'ZALOPAY',          -- ZaloPay (QR)
            'CREDIT_CARD',      -- Thẻ tín dụng
            'VNPAY'             -- VNPay (mở rộng sau)
        ));
    PRINT 'Đã thêm CHECK constraint mới CHK_Payment_method.';
END
ELSE
BEGIN
    PRINT 'CHK_Payment_method đã tồn tại.';
END
GO

-- ============================================================
-- Kiểm tra kết quả
-- ============================================================
SELECT
    t.name          AS [Bảng],
    c.name          AS [Cột],
    cc.name         AS [Tên constraint],
    cc.definition   AS [Định nghĩa]
FROM sys.check_constraints cc
JOIN sys.columns c ON cc.parent_object_id = c.object_id
                   AND cc.parent_column_id = c.column_id
JOIN sys.tables t  ON c.object_id = t.object_id
WHERE t.name IN ('Orders', 'Payment')
ORDER BY t.name, c.name;
GO
