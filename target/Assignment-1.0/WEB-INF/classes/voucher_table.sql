-- ============================================================
-- Script tạo lại bảng Voucher (từ đầu, xóa nếu đã có)
-- Database: Assignment (SQL Server)
-- ============================================================

-- Bước 1: Xóa bảng cũ nếu đã tồn tại
IF OBJECT_ID('dbo.Voucher', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Voucher;
    PRINT 'Đã xóa bảng Voucher cũ.';
END
GO

-- Bước 2: Tạo bảng mới với đúng cột
CREATE TABLE dbo.Voucher (
    id              INT             NOT NULL PRIMARY KEY,
    code            NVARCHAR(50)    NOT NULL UNIQUE,
    title           NVARCHAR(200)   NOT NULL,
    description     NVARCHAR(500)   NULL,
    voucher_type    NVARCHAR(20)    NOT NULL CHECK (voucher_type IN ('PERCENT','FIXED','SHIPPING')),
    discount_value  DECIMAL(12,2)   NOT NULL DEFAULT 0,
    max_discount    DECIMAL(12,2)   NOT NULL DEFAULT 0,
    min_order_value DECIMAL(12,2)   NOT NULL DEFAULT 0,
    category        NVARCHAR(50)    NOT NULL DEFAULT 'discount',
    expiry_date     NVARCHAR(20)    NULL,
    active          BIT             NOT NULL DEFAULT 1
);
PRINT 'Đã tạo bảng Voucher mới thành công.';
GO

-- Bước 3: Thêm dữ liệu mẫu
INSERT INTO dbo.Voucher
    (id, code, title, description, voucher_type, discount_value, max_discount, min_order_value, category, expiry_date, active)
VALUES
    (1, 'FREESHIP2025', N'Miễn phí vận chuyển',
     N'Áp dụng cho mọi đơn hàng, không giới hạn giá trị đơn',
     'SHIPPING', 0, 0, 0, 'shipping', '31/12/2025', 1),

    (2, 'GIAM15', N'Giảm 15% tổng đơn',
     N'Giảm tối đa 100.000đ cho đơn hàng từ 500.000đ',
     'PERCENT', 15, 100000, 500000, 'discount', '31/12/2025', 1),

    (3, 'HOANU10', N'Hoàn xu 10% đơn hàng',
     N'Áp dụng khi thanh toán qua ví điện tử, tối đa 50.000đ',
     'PERCENT', 10, 50000, 200000, 'cashback', '31/12/2025', 1),

    (4, 'RAUSACH50', N'Giảm 50.000đ cho rau củ',
     N'Dành riêng cho danh mục Rau Củ Sạch, đơn tối thiểu 100.000đ',
     'FIXED', 50000, 0, 100000, 'product', '31/12/2025', 1),

    (5, 'CHAOHE2025', N'Chào hè - Giảm 20%',
     N'Ưu đãi mùa hè, giảm tối đa 200.000đ cho đơn từ 300.000đ',
     'PERCENT', 20, 200000, 300000, 'discount', '31/12/2025', 1),

    (6, 'NEWMEMBER', N'Chào mừng thành viên mới',
     N'Giảm cố định 30.000đ cho lần mua đầu tiên',
     'FIXED', 30000, 0, 0, 'discount', '31/12/2025', 1),

    (7, 'FLASHSALE30', N'Flash Sale - Giảm 30%',
     N'Ưu đãi flash sale, giảm tối đa 150.000đ cho đơn từ 250.000đ',
     'PERCENT', 30, 150000, 250000, 'discount', '31/12/2025', 1);

PRINT 'Đã thêm 7 voucher mẫu.';
GO

-- Bước 4: Kiểm tra kết quả
SELECT id, code, title, voucher_type, discount_value, max_discount, min_order_value, category, expiry_date, active
FROM dbo.Voucher
ORDER BY id;
GO
