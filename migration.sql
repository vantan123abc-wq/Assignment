-- Thêm cột is_notified vào bảng Product (chạy 1 lần duy nhất)
ALTER TABLE Product ADD is_notified BIT NOT NULL DEFAULT 0;

-- Tạo bảng Subscribers
CREATE TABLE Subscribers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    isActive BIT DEFAULT 1,
    subscribedAt DATETIME DEFAULT GETDATE()
);

-- Tạo bảng EmailLogs
CREATE TABLE EmailLogs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject NVARCHAR(255),
    content NVARCHAR(MAX),
    sentAt DATETIME DEFAULT GETDATE(),
    productId INT NULL
);
