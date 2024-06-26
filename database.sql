
-- Source ở đây, ae sẽ push source code sql ở đây nhé.

---- CREATE TABLE 
Create Table TIECCUOI  (
    MaTiecCuoi CHAR(10)  PRIMARY KEY,
    MaSanh INT NOT NULL,
    MaCa CHAR(10) NOT NULL,
    MaThucDon INT NOT NULL,
    NgayToChuc DATE NOT NULL,
    TienDatCoc INT NOT NULL,
    MaDichVu INT NOT NULL,
    SoLuongBan INT NOT NULL,
    SoLuongBanDuTru INT NOT NULL,
	UserID CHAR(10) NOT NULL
);
Create Table CA  (
    MaCa CHAR(10) PRIMARY KEY,
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThuc DATETIME NOT NULL
);

Create Table NHANVIEN  (
    MaNhanVien CHAR(10) PRIMARY KEY,
    MaCa CHAR(10) NOT NULL,
    TenNhanVien NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(10) NOT NULL,
    ChucVu NVARCHAR(100) NOT NULL
);

Create table THUCDON 
(
	MaThucDon INT primary key,
	MonKhaiVi nvarchar(100) not null,
	MonChinh1 nvarchar(100)not null,
	MonChinh2 nvarchar(100) not null,
	MonChinh3 nvarchar(100) not null,
	Lau nvarchar(100) not null,
	TrangMieng nvarchar(100) not null,
	Bia nvarchar(100) not null,
	NuocNgot nvarchar(100)not null,
	GiaThucDon money not null,
    TenThucDon nvarchar(100)
);

CREATE TABLE NGUOIDUNG (
    UserID CHAR(10) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    AccountType NVARCHAR(20) NOT NULL, -- Ví dụ: 'customer', 'admin'
    PhoneNumber NVARCHAR(20) NOT NULL
);



create table HOADON 
(
 MaHoaDon int(10) Primary key,
 MaTiecCuoi char(10) not null,
 NgayThanhToan date not null,
 TongTienBan int not null,
 TongTienThucDon int not null,
 TongTienHoaDon int not null,
 TinhTrangThanhToan NVARCHAR(100) NOT NULL,
 TienPhat INT

)

CREATE TABLE THANHTOAN
(
    MaThanhToan INT PRIMARY KEY,
    MaHoaDon INT,
    NgayThanhToan date not null,
    SoTienPhat INT
);
	
CREATE TABLE SANH (
    MaSanh INT PRIMARY KEY,
    TenSanh VARCHAR(255),
    DonGia DECIMAL(10, 2),
    DiaChi NVARCHAR(255)
);

CREATE TABLE DICHVU (
    MaDichVu INT PRIMARY KEY,
    TenDichVu NVARCHAR(255),
    DonGia DECIMAL(13, 2)
);

--Nhan dat tiec khi SANH trong
--SELECT *
--FROM SANH
--WHERE NOT EXISTS (
--    SELECT 1
--   FROM TIECCUOI
--    WHERE TIECCUOI.MaSanh = MaSanh
--    AND TIECCUOI.NgayToChuc = 'Ngày muốn đặt'
--    AND TIECCUOI.MaCa = 'Ca muốn đặt'
--); 

CREATE TABLE ChiTietBaoCao 
(
	MaBaoCao varchar(10) PRIMARY KEY,
	NGAY DATE NOT NULL,
	SoLuong INT NOT NULL,
	DoanhThu INT NOT NULL,
	TienThu INT NOT NULL,
	TienNo INT NOT NULL
)
CREATE TABLE BaoCaoDoanhThu 
(
	MaBaoCao varchar(10) PRIMARY KEY,
	Thang char(20) NOT NULL,
	TongDoanhThu INT NOT NULL,
	TienThu INT NOT NULL,
	TienNo INT NOT NULL
)

GO
----------- CREATE FOREIGN KEY ---------------------------- 

-- TABLE TIECCUOI
ALTER TABLE TIECCUOI ADD CONSTRAINT FK_MaSanh
FOREIGN KEY (MaSanh)
REFERENCES SANH(MaSanh)

ALTER TABLE TIECCUOI
ADD CONSTRAINT FK_MaCa
FOREIGN KEY (MaCa)
REFERENCES CA(MaCa)

ALTER TABLE TIECCUOI
ADD CONSTRAINT FK_MaThucDon
FOREIGN KEY (MaThucDon)
REFERENCES THUCDON(MaThucDon)

ALTER TABLE TIECCUOI
ADD CONSTRAINT FK_NguoiDung
FOREIGN KEY (UserID)
REFERENCES NGUOIDUNG(UserID)

ALTER TABLE TIECCUOI
ADD CONSTRAINT FK_HoaDon
FOREIGN KEY (MaHoaDon)
REFERENCES HOADON(MaHoaDon)

ALTER TABLE TIECCUOI
ADD CONSTRAINT FK_DichVu
FOREIGN KEY (MaDichVu)
REFERENCES DICHVU(MaDichVu)
GO
-- TABLE NHANVIEN 
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_MaCa
FOREIGN KEY (MaCa)
REFERENCES CA(MaCa)

GO
-- TABLE ChiTietBaoCao
ALTER TABLE ChiTietBaoCao
ADD CONSTRAINT FK_MaBaoCao
FOREIGN KEY (MaBaoCao)
REFERENCES BaoCaoDoanhThu(MaBaoCao)

GO
-- Table HoaDon
ALTER TABLE HOADON
ALTER COLUMN TongTienHoaDon INT NULL;

GO
--- Table THANHTOAN 
ALTER TABLE THANHTOAN
ADD CONSTRAINT FK_THANHTOAN
FOREIGN KEY (MaHoaDon)
REFERENCES HOADON(MaHoaDon)
GO

------------ INSERT INTO DATA ----------------------------

-- TABLE SANH
INSERT INTO SANH (MaSanh, TenSanh, DonGia, DiaChi) VALUES
    (1, 'EmpTower Center', 372.00, N'30 Bình Dã - Quận 3 - Tp.HCM'),
    (2, 'Venues Center', 350.00, N'98/2 Bình Dũ - Quận 2 - TP.HCM'),
    (3, 'Hoàng Gia Center', 400.00, N'70/10 Lê Đại Hành - Quận 1 - TP.HCM'),
    (4, 'White Palace', 420.00, N'194 Hoàng Văn Thụ, Q. Phú Nhuận, TP. Hồ Chí Minh'),
    (5, 'Grand Palace', 400.00, N'588 Phạm Văn Đồng, Thủ Đức, TP. Hồ Chí Minh'),
    (6, 'Riverside Palace', 380.00, N'360D Bến Vân Đồn, Quận 4, TP. HCM'),
    (7, 'Melisa Center', 350.00, N'85 Thoại Ngọc Hầu, Quận Tân Phú, TP. HCM'),
    (8, 'Diamond Place', 380.00, N'03 Đặng Văn Sâm, Q. Phú Nhuận, TP. HCM'),
    (9, 'Aqua Palace', 420.00, N'90 Hai Bà Trưng, Q.1, TP. HCM');

	
-- TABLE CA
INSERT INTO CA (MaCa, ThoiGianBatDau, ThoiGianKetThuc)
VALUES 
    ('Ca001', '2024-05-01 08:00:00', '2024-05-01 12:00:00'),
    ('Ca002', '2024-05-01 13:00:00', '2024-05-01 17:00:00'),
    ('Ca003', '2024-05-02 08:00:00', '2024-05-02 12:00:00'),
    ('Ca004', '2024-05-02 13:00:00', '2024-05-02 17:00:00'),
    ('Ca005', '2024-05-03 08:00:00', '2024-05-03 12:00:00');


--- TABLE THUCDON
INSERT INTO THUCDON VALUES
(1, N'Chả Giò Rế Hà Nội', N'Gà Ấp Chảo + Bánh Bao', N'Dê Hấp Lá Tía Tô', N'Tôm Sông Rang Muối', N'Lẩu Thái Hải Sản', N'Thanh Nhiệt Sâm Sâm', N'Heniken', N'Pepsi', N'2000000', N'Thực Đơn Phong Vị Hà Nội'),
(2, N'Suop Cua Gà Xé', N'Gà Bó Xôi', N'Bò Nấu Đậu + Bánh Mì', N'Vịt Quay Bắc Kinh', N'Lẩu Nấm Hải Sản', N'Chè Hạt Sen', N'Tiger Bạc', N'Trà Xanh', N'1800000', N'Thực Đơn Ngọc Sắc Bắc'),
(3, N'Gỏi Gỏi Sen Tôm Thịt', N'Gà Hấp Hành + Xôi', N'Cá Điêu Hồng Chưng Tương', N'Chim Cút Roti + Bánh Mì', N'Lẩu Thái Hải Sản', N'Chè Hạt Sen', N'Heniken', N'Cocacola', N'2000000', N'Thực Đơn Sen Vàng Mỹ Vị'),
(4, N'Suop Hải Sản Nấm Tuyết', N'Gà Nấu Lagu + Bánh Mì', N'Cá Điêu Hồng Hấp HongKong', N'Gà Bó Xôi', N'Lẩu Cua Đồng', N'Rau Câu Ngũ Sắc', N'Tiger', N'Pepsi', N'1800000', N'Thực Đơn Hải Vị Ngọc Tuyết'),
(5, N'Chả Giò Venus', N'Chim Cút Roti + Bánh Mì', N'Tôm Sông Rang Muối', N'Cá Điêu Hồng Chưng Tương', N'Lẩu Cá Bớp', N'Chè Khúc Bạch', N'Heniken', N'Pepsi', N'2000000', N'Thực Đơn Điêu Hồng Tinh Hoa');


--- TABLE NGUOIDUNG
INSERT INTO NGUOIDUNG (UserID, FullName, Email, PasswordHash, AccountType,PhoneNumber)
VALUES 
    ('KH001', N'Nguyễn Văn Khánh', 'khanh@example.com', 'hashed_password1', 'customer','0918123456'),
    ('KH002', N'Trần Thị Hương', 'huong@example.com', 'hashed_password2', 'customer','0987123456'),
    ('KH003', N'Lê Minh Anh', 'anh@example.com', 'hashed_password3', 'customer','0917123456'),
    ('KH004', N'Phạm Quốc Trung', 'trung@example.com', 'hashed_password4', 'customer','0908123456'),
    ('KH005', N'Huỳnh Thị Lan', 'lan@example.com', 'hashed_password5', 'customer','0978123456'),
    ('AD001', N'Admin', 'admin@example.com', 'hashed_admin_password', 'admin','0987654321');


-- TABLE TIECCUOI
INSERT INTO TIECCUOI (MaTiecCuoi, MaSanh, MaCa, MaThucDon, NgayToChuc, TienDatCoc, MaDichVu, SoLuongBan, SoLuongBanDuTru, UserID)
VALUES
    ('TC001', 1, 'Ca001', 1, 5000000, 1, 10, 2, 'KH001'),
    ('TC002', 2, 'Ca002', 2, 6000000, 2, 15, 3, 'KH002'),
    ('TC003', 3, 'Ca001', 3,  7000000, 3, 20, 4, 'KH003'),
    ('TC004', 2, 'Ca002', 2, 8000000, 4, 25, 5, 'KH004'),
    ('TC005', 1, 'Ca001', 1,  9000000, 5, 30, 6, 'KH005');

-- TABLE NHANVIEN
INSERT INTO NHANVIEN (MaNhanVien, MaCa, TenNhanVien, SoDienThoai, ChucVu)
VALUES 
    ('NV001', 'Ca001', N'Trần Văn A', '1234567890', N'Quản lý'),
    ('NV002', 'Ca002', N'Nguyễn Thị B', '0987654321', N'Nhân viên bán hàng'),
    ('NV003', 'Ca003', N'Lê Văn C', '0123456789', N'Nhân viên phục vụ'),
    ('NV004', 'Ca004', N'Phạm Thị D', '0987123456', N'Nhân viên pha chế'),
    ('NV005', 'Ca005', N'Huỳnh Văn E', '0123987654', N'Nhân viên dọn dẹp');



-- TABLE HOADON
INSERT INTO HOADON (MaHoaDon, MaTiecCuoi, NgayThanhToan, TongTienBan, TongTienThucDon, TongTienHoaDon)
VALUES 
    (1, 'TC001', '2023-01-10', 5000000, 5000000, 5500000),
    (2, 'TC002', '2024-01-12', 7000000, 5000000, 7500000),
    (3, 'TC003', '2023-11-22', 6000000, 5000000, 6500000),
    (4, 'TC004', '2023-01-13', 8000000, 5000000, 8500000),
    (5, 'TC005', '2024-01-15', 6000000, 5000000, 6500000);


-- TABLE ChiTietBaoCao
INSERT INTO ChiTietBaoCao (MaBaoCao, NGAY, SoLuong, DoanhThu, TienThu, TienNo)
VALUES 
    ('CTBC001', '2024-01-01', 10, 100000, 70000, 30000),
    ('CTBC002', '2024-01-02', 20, 120000, 80000, 40000),
    ('CTBC003', '2024-01-03', 30, 150000, 100000, 50000),
    ('CTBC004', '2024-01-04', 40, 130000, 90000, 40000),
    ('CTBC005', '2024-01-05', 50, 140000, 95000, 45000),
    ('CTBC006', '2024-01-06', 60, 160000, 110000, 50000),
    ('CTBC007', '2024-01-07', 70, 170000, 115000, 55000),
    ('CTBC008', '2024-01-08', 80, 190000, 130000, 60000),
    ('CTBC009', '2024-01-09', 90, 200000, 140000, 60000),
    ('CTBC010', '2024-01-10', 100, 210000, 145000, 65000),
    ('CTBC011', '2024-01-11', 110, 220000, 150000, 70000),
    ('CTBC012', '2024-01-12', 120, 12000000, 11500000, 1100000),
    ('CTBC013', '2024-01-13', 130, 13000000, 12500000, 1200000),
    ('CTBC014', '2024-01-14', 140, 14000000, 13500000, 1300000),
    ('CTBC015', '2024-01-15', 150, 15000000, 14500000, 1400000),
    ('CTBC016', '2024-01-16', 160, 16000000, 15500000, 1500000),
    ('CTBC017', '2024-01-17', 170, 17000000, 16500000, 1600000),
    ('CTBC018', '2024-01-18', 180, 18000000, 17500000, 1700000),
    ('CTBC019', '2024-01-19', 190, 19000000, 18500000, 1800000),
    ('CTBC020', '2024-01-20', 200, 20000000, 19500000, 1900000),
    ('CTBC021', '2024-01-21', 210, 21000000, 20500000, 2000000),
    ('CTBC022', '2024-01-22', 220, 22000000, 21500000, 2100000),
    ('CTBC023', '2024-05-23', 230, 23000000, 22500000, 2200000),
    ('CTBC024', '2024-05-24', 240, 24000000, 23500000, 2300000),
    ('CTBC025', '2024-05-25', 250, 25000000, 24500000, 2400000),
    ('CTBC026', '2024-05-26', 260, 26000000, 25500000, 2500000),
    ('CTBC027', '2024-05-27', 270, 27000000, 26500000, 2600000),
    ('CTBC028', '2024-05-28', 280, 28000000, 27500000, 2700000),
    ('CTBC029', '2024-05-29', 290, 29000000, 28500000, 2800000),
    ('CTBC030', '2024-05-30', 300, 30000000, 29500000, 2900000);


-- TABLE BaoCaoDoanhThu
INSERT INTO BaoCaoDoanhThu (MaBaoCao, Thang, TongDoanhThu, TienThu, TienNo)
VALUES 
('CTBC001', 'Tháng 1', 100000, 70000, 30000),
('CTBC002', 'Tháng 2', 120000, 80000, 40000),
('CTBC003', 'Tháng 3', 150000, 100000, 50000),
('CTBC004', 'Tháng 4', 130000, 90000, 40000),
('CTBC005', 'Tháng 5', 140000, 95000, 45000),
('CTBC006', 'Tháng 6', 160000, 110000, 50000),
('CTBC007', 'Tháng 7', 170000, 115000, 55000),
('CTBC008', 'Tháng 8', 180000, 120000, 60000),
('CTBC009', 'Tháng 9', 190000, 130000, 60000),
('CTBC010', 'Tháng 10', 200000, 140000, 60000),
('CTBC011', 'Tháng 11', 210000, 145000, 65000),
('CTBC012', 'Tháng 12', 220000, 150000, 70000);


INSERT INTO DICHVU(MaDichVu, TenDichVu, DonGia)  VALUES
(1, N'Ca Sĩ', 30000000.00),
(2, N'Bánh Kem', 1200000.00),
(3, N'Váy Cưới', 150000000.00),
(4, N'Tuxedo', 50000000.00),
(5, N'Chụp Hình', 800000.00),
(6, N'Trang Điểm', 2000000.00)



-- PROCEDURE
-- Tạo procedure thêm, cập nhật, và xóa loại sảnh
CREATE PROCEDURE QuanLyLoaiSanh
    @MaSanh INT,
    @TenSanh NVARCHAR(255),
    @DonGia DECIMAL(10, 2),
    @DiaChi NVARCHAR(255),
    @Action NVARCHAR(10)
AS
BEGIN
    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO SANH (MaSanh, TenSanh, DonGia, DiaChi)
        VALUES (@MaSanh, @TenSanh, @DonGia, @DiaChi);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE SANH
        SET TenSanh = @TenSanh,
            DonGia = @DonGia,
            DiaChi = @DiaChi
        WHERE MaSanh = @MaSanh;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM SANH
        WHERE MaSanh = @MaSanh;
    END
END;
GO
-- Tạo procedure cho thêm, chỉnh sửa, và xóa thực đơn
CREATE PROCEDURE QuanLyThucDon
    @MaThucDon INT,
    @MonKhaiVi NVARCHAR(100),
    @MonChinh1 NVARCHAR(100),
    @MonChinh2 NVARCHAR(100),
    @MonChinh3 NVARCHAR(100),
    @Lau NVARCHAR(100),
    @TrangMieng NVARCHAR(100),
    @Bia NVARCHAR(100),
    @NuocNgot NVARCHAR(100),
    @GiaThucDon MONEY,
    @Action NVARCHAR(10)
AS
BEGIN
    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO THUCDON (MaThucDon, MonKhaiVi, MonChinh1, MonChinh2, MonChinh3, Lau, TrangMieng, Bia, NuocNgot, GiaThucDon)
        VALUES (@MaThucDon, @MonKhaiVi, @MonChinh1, @MonChinh2, @MonChinh3, @Lau, @TrangMieng, @Bia, @NuocNgot, @GiaThucDon);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE THUCDON
        SET MonKhaiVi = @MonKhaiVi,
            MonChinh1 = @MonChinh1,
            MonChinh2 = @MonChinh2,
            MonChinh3 = @MonChinh3,
            Lau = @Lau,
            TrangMieng = @TrangMieng,
            Bia = @Bia,
            NuocNgot = @NuocNgot,
            GiaThucDon = @GiaThucDon
        WHERE MaThucDon = @MaThucDon;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM THUCDON WHERE MaThucDon = @MaThucDon;
    END
END;
GO

-- Tạo procedure cho thêm, cập nhật, và xóa ca
CREATE PROCEDURE QuanLyCa
    @MaCa CHAR(10),
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @Action NVARCHAR(10)
AS
BEGIN
    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO CA (MaCa, ThoiGianBatDau, ThoiGianKetThuc)
        VALUES (@MaCa, @ThoiGianBatDau, @ThoiGianKetThuc);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE CA
        SET ThoiGianBatDau = @ThoiGianBatDau,
            ThoiGianKetThuc = @ThoiGianKetThuc
        WHERE MaCa = @MaCa;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM CA WHERE MaCa = @MaCa;
    END
END;
GO

EXEC QuanLyLoaiSanh'S06', 'Loai F', 'Bạch Kim 2', 350, 25000000, 'Ghi chú', 'INSERT';
EXEC QuanLyThucDon'TD006', 'Gỏi Cuốn', 'Bò Tái Chanh', 'Cá Hồi', 'Cánh Gà Chiên Nước Mắm', 'Lẩu Hải Sản', 'Kem Flan', 'Sapporo', 'Cocacola', 2200000, 'INSERT';
EXEC QuanLyCa'Ca006', '2024-05-04 18:00:00', '2024-05-04 22:00:00', 'INSERT';
--Procdure : Nếu NgayThanhToan (HoaDon) > NgayThanhToan (ThanhToan) thì TienPhat (ThanhToan) = 10% TongTien(HoaDon)
CREATE PROCEDURE PhatThanhToan
    @MaHoaDon INT,
    @NgayThanhToan DATE,
    @SoTienPhat INT OUTPUT
AS
BEGIN
    -- Khởi tạo số tiền phạt
    SET @SoTienPhat = 0;

    -- Thêm hồ sơ thanh toán
    INSERT INTO THANHTOAN (MaHoaDon, NgayThanhToan)
    VALUES (@MaHoaDon, @NgayThanhToan);

    -- Kiểm tra xem ngày thanh toán có muộn hơn ngày lập hoá đơn không
    IF EXISTS (
        SELECT 1
        FROM HOADON
        WHERE MaHoaDon = @MaHoaDon
        AND NgayThanhToan < @NgayThanhToan
    )
    BEGIN
    --Tính tiền phạt là 10% tổng hóa đơn 
        SELECT @SoTienPhat = 0.1 * TongTienHoaDon
        FROM HOADON
        WHERE MaHoaDon = @MaHoaDon;
    END
END
--Tạo Procdure : Nhập UserID sẽ trả về : Tên Người Dùng(NGUOIDUNG) ,Tên Sảnh(SANH), Thời Gian (Ca), Tên Thực Đơn(THUCDON), Tên Dịch Vụ(DICHVU)

CREATE PROCEDURE NhanVeThongTinNguoiDung
    @UserID CHAR(10)
AS
BEGIN
    SELECT 
        NGUOIDUNG.FullName AS UserName,
        SANH.TenSanh AS VenueName,
        CA.ThoiGianBatDau AS StartTime,
        CA.ThoiGianKetThuc AS EndTime,
        THUCDON.MonKhaiVi,
        THUCDON.MonChinh1,
        THUCDON.MonChinh2,
        THUCDON.MonChinh3,
        THUCDON.Lau,
        THUCDON.TrangMieng,
        THUCDON.Bia,
        THUCDON.NuocNgot,
        THUCDON.GiaThucDon,
        DICHVU.TenDichVu,
        DICHVU.DonGia
    FROM TIECCUOI
    JOIN NGUOIDUNG ON TIECCUOI.UserID = NGUOIDUNG.UserID
    JOIN SANH ON TIECCUOI.MaSanh = SANH.MaSanh
    JOIN CA ON TIECCUOI.MaCa = CA.MaCa
    JOIN THUCDON ON TIECCUOI.MaThucDon = THUCDON.MaThucDon
    JOIN DICHVU ON TIECCUOI.MaDichVu = DICHVU.MaDichVu
    WHERE TIECCUOI.UserID = @UserID;
END
-- Tạo Procedure Xóa dịch vụ
CREATE PROCEDURE DeleteDichVuWithDependencies @MaDichVu INT
AS
BEGIN
    -- Kiểm tra có hóa đơn nào liên quan đến tiệc cưới không
    IF EXISTS (
        SELECT 1
        FROM TIECCUOI tc
        INNER JOIN HOADON hd ON tc.MaTiecCuoi = hd.MaTiecCuoi
        WHERE tc.MaDichVu = @MaDichVu
    )
    BEGIN
        -- Xóa các hóa đơn liên quan
        DELETE FROM HOADON
        WHERE MaTiecCuoi IN (
            SELECT MaTiecCuoi
            FROM TIECCUOI
            WHERE MaDichVu = @MaDichVu
        );
        
        -- Xóa tiệc cưới
        DELETE FROM TIECCUOI
        WHERE MaDichVu = @MaDichVu;
        
        -- Xóa dịch vụ
        DELETE FROM DICHVU
        WHERE MaDichVu = @MaDichVu;
        
        PRINT 'Đã xóa dịch vụ và dữ liệu liên quan thành công.';
    END
    ELSE
    BEGIN
        -- Nếu không có hóa đơn liên quan, xóa trực tiếp dịch vụ
        DELETE FROM DICHVU
        WHERE MaDichVu = @MaDichVu;
        
        PRINT 'Xóa dịch vụ thành công.';
    END
END;
-- Thực thi
EXEC DeleteDichVuWithDependencies @MaDichVu = 1;



--- Tao Procedure them, xoa sua Tiec Cuoi => thay doi them, xoa sua HoaDon
-- Insert TiecCuoi
CREATE PROCEDURE InsertHoaDon
    @MaTiecCuoi CHAR(10),
    @NgayToChuc DATE,
    @SoLuongBan INT,
    @MaSanh CHAR(10),
    @MaThucDon INT,
    @UserID CHAR(10)
AS
BEGIN
	DECLARE @MaHoaDon INT;

    -- Lấy MaHoaDon cuối cùng trong bảng HOADON
    SELECT @MaHoaDon = ISNULL(MAX(MaHoaDon), 0) + 1 FROM HOADON;
    INSERT INTO HOADON (MaHoaDon, MaTiecCuoi, NgayThanhToan, TongTienBan, TongTienThucDon, TongTienHoaDon)
    VALUES (
        @MaHoaDon, 
        @MaTiecCuoi, 
        @NgayToChuc, 
        (SELECT SoLuongBan * DonGia FROM TIECCUOI tc JOIN SANH s ON tc.MaSanh = s.MaSanh WHERE tc.MaTiecCuoi = @MaTiecCuoi),
        (SELECT SoLuongBan * GiaThucDon FROM TIECCUOI tc JOIN THUCDON td ON tc.MaThucDon = td.MaThucDon WHERE tc.MaTiecCuoi = @MaTiecCuoi),
		(SELECT (SoLuongBan * DonGia) + (SoLuongBan * GiaThucDon) FROM TIECCUOI tc JOIN SANH s ON tc.MaSanh = s.MaSanh JOIN THUCDON td ON tc.MaThucDon = td.MaThucDon WHERE tc.MaTiecCuoi = @MaTiecCuoi)
    );
END;
GO

-- Update TiecCuoi
CREATE PROCEDURE UpdateHoaDon
    @MaTiecCuoi CHAR(10),
    @NgayToChuc DATE,
    @SoLuongBan INT,
    @MaSanh CHAR(10),
    @MaThucDon CHAR(10),
    @UserID CHAR(10)
AS
BEGIN
    UPDATE HOADON
    SET 
        NgayThanhToan = @NgayToChuc, 
        TongTienBan = (SELECT SoLuongBan * DonGia FROM TIECCUOI tc JOIN SANH s ON tc.MaSanh = s.MaSanh WHERE tc.MaTiecCuoi = @MaTiecCuoi),
        TongTienThucDon = (SELECT SoLuongBan * GiaThucDon FROM TIECCUOI tc JOIN THUCDON td ON tc.MaThucDon = td.MaThucDon WHERE tc.MaTiecCuoi = @MaTiecCuoi)
        TongTienHoaDon = 
    WHERE 
        MaTiecCuoi = @MaTiecCuoi;
END;
GO

-- Delete TiecCuoi
CREATE PROCEDURE DeleteHoaDon
    @MaTiecCuoi CHAR(10)
AS
BEGIN
    DELETE FROM HOADON
    WHERE 
        MaTiecCuoi = @MaTiecCuoi;
END;
GO
---Procdure Them TIECCUOI
--IF trung SANH & CA -> "Sảnh và thời gian đã có người đặt"
--ELSE -> "Đặt thành công"
CREATE PROCEDURE ThemTiecCuoi
    @MaTiecCuoi CHAR(10),
    @MaSanh INT,
    @MaCa CHAR(10),
    @MaThucDon INT,
    @NgayToChuc DATE,
    @TienDatCoc INT,
    @MaDichVu INT,
    @SoLuongBan INT,
    @SoLuongBanDuTru INT,
    @UserID CHAR(10),
    @NgayToChuc DATE
AS
BEGIN
    -- Kiểm tra trùng lặp MaSanh và MaCa
    IF EXISTS (SELECT 1
               FROM TIECCUOI
               WHERE MaSanh = @MaSanh AND MaCa = @MaCa AND NgayToChuc = @NgayToChuc)
    BEGIN
        -- Nếu trùng lặp, trả về thông báo lỗi
        SELECT 'Sảnh và thời gian đã có người đặt' AS KetQua;
    END
    ELSE
    BEGIN
        -- Nếu không trùng lặp, tiến hành thêm tiệc cưới mới
        INSERT INTO TIECCUOI (
            MaTiecCuoi, 
            MaSanh, 
            MaCa, 
            MaThucDon, 
            NgayToChuc, 
            TienDatCoc, 
            MaDichVu, 
            SoLuongBan, 
            SoLuongBanDuTru, 
            UserID,
            NgayToChuc
        )
        VALUES (
            @MaTiecCuoi, 
            @MaSanh, 
            @MaCa, 
            @MaThucDon, 
            @NgayToChuc, 
            @TienDatCoc, 
            @MaDichVu, 
            @SoLuongBan, 
            @SoLuongBanDuTru, 
            @UserID,
            @NgayToChuc
        );

        -- Trả về thông báo thành công
        SELECT 'Đặt Thành Công' AS KetQua;
    END
END;

---Procdure Xóa SANH =>  Xóa các bảng ràng buộc liên quan luôn (TIECCUOI), nếu tồn tại HOADON thì xóa HOADON->TIECCUOI->SANH
CREATE PROCEDURE XoaSanh
    @MaSanh INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Xóa các bản ghi liên quan trong bảng TIECCUOI
        DELETE FROM TIECCUOI
        WHERE MaSanh = @MaSanh;

        -- Xóa bản ghi trong bảng SANH
        DELETE FROM SANH
        WHERE MaSanh = @MaSanh;

        COMMIT TRANSACTION;
        SELECT 'Xóa thành công' AS KetQua;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Xóa các hóa đơn liên quan trong bảng HOADON
            DELETE FROM HOADON
            WHERE MaTiecCuoi IN (
                SELECT MaTiecCuoi
                FROM TIECCUOI
                WHERE MaSanh = @MaSanh
            );

            -- Xóa các bản ghi liên quan trong bảng TIECCUOI
            DELETE FROM TIECCUOI
            WHERE MaSanh = @MaSanh;

            -- Xóa bản ghi trong bảng SANH
            DELETE FROM SANH
            WHERE MaSanh = @MaSanh;

            COMMIT TRANSACTION;
            SELECT 'Xóa thành công' AS KetQua;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            SELECT @ErrorMessage AS KetQua;
        END CATCH
    END CATCH
END;

---Procdure Xóa THUCDON => Xóa các bảng ràng buộc liên quan (TIECCUOI), nếu tồn tại HOADON thì xóa HOADON->TIECCUOI->THUCDON
CREATE PROCEDURE XoaThucDon
    @MaThucDon INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Xóa các bản ghi liên quan trong bảng TIECCUOI
        DELETE FROM TIECCUOI
        WHERE MaThucDon = @MaThucDon;

        -- Xóa bản ghi trong bảng THUCDON
        DELETE FROM THUCDON
        WHERE MaThucDon = @MaThucDon;

        COMMIT TRANSACTION;
        SELECT 'Xóa thành công' AS KetQua;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Xóa các hóa đơn liên quan trong bảng HOADON
            DELETE FROM HOADON
            WHERE MaTiecCuoi IN (
                SELECT MaTiecCuoi
                FROM TIECCUOI
                WHERE MaThucDon = @MaThucDon
            );

            -- Xóa các bản ghi liên quan trong bảng TIECCUOI
            DELETE FROM TIECCUOI
            WHERE MaThucDon = @MaThucDon;

            -- Xóa bản ghi trong bảng THUCDON
            DELETE FROM THUCDON
            WHERE MaThucDon = @MaThucDon;

            COMMIT TRANSACTION;
            SELECT 'Xóa thành công sau khi thử lại' AS KetQua;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            SELECT @ErrorMessage AS KetQua;
        END CATCH
    END CATCH
END;


---- TRIGER 
-- Xoa bo trung lap MaTiecCuoi trong bang HOADON
CREATE TRIGGER RemoveDuplicateMaTiecCuoi
ON HOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa các bản ghi trùng lặp
    ;WITH CTE AS (
        SELECT ROW_NUMBER() OVER(PARTITION BY MaTiecCuoi ORDER BY (SELECT NULL)) AS RowNum
        FROM HOADON
    )
    DELETE FROM CTE WHERE RowNum > 1;
END;
GO
--Doanh thu thang tu dong cap nhat moi khi them, sua, xoa ChiTietBaoCao
CREATE TRIGGER Update_Doanh_Thu_Thang
ON ChiTietBaoCao
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    
    
    -- Lấy tháng của ChiTietBaoCao
    SELECT  MONTH(Ngay) AS @Thang
	FROM ChiTietBaoCao;

    -- Cập nhật BaoCaoDoanhThu
    UPDATE BaoCaoDoanhThu
    SET DoanhThuThang = (
        SELECT SUM(DoanhThu)
        FROM ChiTietBaoCao
        WHERE MONTH(NGAY) = @Thang
    )
    WHERE Thang = @Thang 
END;

CREATE OR ALTER TRIGGER trg_UpdateTinhTrangThanhToan
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE hd
    SET hd.TinhTrangThanhToan = CASE
                                    WHEN i.TinhTrangThanhToan = N'Đã Thanh Toán' THEN i.TinhTrangThanhToan
                                    WHEN i.NgayThanhToan > GETDATE() THEN N'Chưa Thanh Toán'
                                    ELSE N'Quá Hạn'
                                END
    FROM HOADON AS hd
    JOIN inserted AS i ON hd.MaHoaDon = i.MaHoaDon;
END

CREATE OR ALTER PROCEDURE GetAllInvoiceDetails
AS
BEGIN
    SELECT
        ND.FullName AS 'Họ Tên',
        ND.Email AS 'Tên đăng nhập',
        ND.PhoneNumber AS 'Số điện thoại',
        HD.MaHoaDon AS 'Mã hóa đơn',
        HD.TongTienHoaDon AS 'Tổng tiền thanh toán',
        TC.NgayToChuc AS 'Ngày thanh toán',
        HD.TinhTrangThanhToan AS 'Tình trạng thanh toán',
		TC.MaTiecCuoi AS 'Ma Tiec Cuoi',
		HD.TienPhat AS 'TienPhat',
		TC.MaSanh AS 'Ma Sanh',
		TC.MaThucDon AS 'Ma Thuc Don',
		TC.MaDichVu AS 'MaDichVu',
		TC.TienDatCoc as 'TienCoc'
    FROM
        HOADON HD
    JOIN
        TIECCUOI TC ON HD.MaTiecCuoi = TC.MaTiecCuoi
    JOIN
        NGUOIDUNG ND ON TC.UserID = ND.UserID;
END;


EXEC GetAllInvoiceDetails;
--- Trigger => yêu cầu :  Mỗi khi update ChiTietBaoCao => DoanhThu & TienNo & TienThu của BaoCaoDoanhThu sẽ bằng DoanhThu & TienThu &  TienNo các ngày cùng tháng cộng lại
CREATE TRIGGER UpdateBaoCaoDoanhThu
ON ChiTietBaoCao
AFTER UPDATE
AS
BEGIN
    DECLARE @Thang CHAR(20);
    DECLARE @TongDoanhThu INT;
    DECLARE @TienThu INT;
    DECLARE @TienNo INT;
    
    -- Lấy tháng từ ngày của ChiTietBaoCao
    SELECT @Thang = FORMAT(INSERTED.NGAY, 'yyyy-MM')
    FROM INSERTED;

    -- Tính tổng DoanhThu, TienThu, TienNo của các ngày cùng tháng
    SELECT 
        @TongDoanhThu = ISNULL(SUM(DoanhThu), 0), 
        @TienThu = ISNULL(SUM(TienThu), 0), 
        @TienNo = ISNULL(SUM(TienNo), 0)
    FROM ChiTietBaoCao
    WHERE FORMAT(NGAY, 'yyyy-MM') = @Thang;

    -- Cập nhật BaoCaoDoanhThu với các giá trị đã tính toán
    UPDATE BaoCaoDoanhThu
    SET 
        TongDoanhThu = @TongDoanhThu, 
        TienThu = @TienThu, 
        TienNo = @TienNo
    WHERE Thang = @Thang;
END;
GO
---tạo trigger update ChiTietHoaDon
CREATE TRIGGER Update_ChiTietBaoCao
ON HOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Xử lý các phần insert và update
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        MERGE ChiTietBaoCao AS target
        USING (
            SELECT 
                MaHoaDon, 
                NgayThanhToan, 
                TongTienHoaDon,
                TinhTrangThanhToan
            FROM inserted
        ) AS source (MaHoaDon, NgayThanhToan, TongTienHoaDon, TinhTrangThanhToan)
        ON target.MaBaoCao = source.MaHoaDon
        WHEN MATCHED THEN
            UPDATE SET 
                NGAY = source.NgayThanhToan,
                TienThu = CASE 
                            WHEN source.TinhTrangThanhToan = N'Đã thanh toán' 
                            THEN source.TongTienHoaDon 
                            ELSE 0 
                          END,
                TienNo = CASE 
                            WHEN source.TinhTrangThanhToan <> N'Đã thanh toán' 
                            THEN source.TongTienHoaDon 
                            ELSE 0 
                         END
        WHEN NOT MATCHED THEN
            INSERT (MaBaoCao, NGAY, SoLuong, DoanhThu, TienThu, TienNo)
            VALUES (
                source.MaHoaDon, 
                source.NgayThanhToan, 
                0,  -- SoLuong
                0,  -- DoanhThu
                CASE 
                    WHEN source.TinhTrangThanhToan = N'Đã thanh toán' 
                    THEN source.TongTienHoaDon 
                    ELSE 0 
                END,  -- TienThu
                CASE 
                    WHEN source.TinhTrangThanhToan <> N'Đã thanh toán' 
                    THEN source.TongTienHoaDon 
                    ELSE 0 
                END  -- TienNo
            );
    END

    -- Xử lý deletes
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE ChiTietBaoCao
        SET 
            TienThu = CASE 
                        WHEN d.TinhTrangThanhToan = N'Đã thanh toán' 
                        THEN ChiTietBaoCao.TienThu - d.TongTienHoaDon 
                        ELSE ChiTietBaoCao.TienThu 
                      END,
            TienNo = CASE 
                        WHEN d.TinhTrangThanhToan <> N'Đã thanh toán' 
                        THEN ChiTietBaoCao.TienNo - d.TongTienHoaDon 
                        ELSE ChiTietBaoCao.TienNo 
                     END
        FROM deleted d
        WHERE ChiTietBaoCao.MaBaoCao = d.MaHoaDon;
    END
END;


drop table ChiTietBaoCao;
DROP TABLE HOADON;

-- Insert data vào ChiTietBaoCao
INSERT INTO ChiTietBaoCao (MaBaoCao, NGAY, SoLuong, DoanhThu, TienThu, TienNo)
VALUES 
    ('BC001', '2024-05-15', 0, 0, 0, 0),
    ('BC002', '2024-05-16', 0, 0, 0, 0),
    ('BC003', '2024-05-17', 0, 0, 0, 0);

-- Insert data vào HOADON
INSERT INTO HOADON (MaHoaDon, MaTiecCuoi, NgayThanhToan, TongTienBan, TongTienThucDon, TongTienHoaDon, TinhTrangThanhToan)
VALUES 
    ('HD001', 'TC001', '2024-05-15', 500000, 200000, 700000, N'Đã thanh toán'),
    ('HD002', 'TC002', '2024-05-16', 600000, 250000, 850000, N'Chưa thanh toán'),
    ('HD003', 'TC003', '2024-05-17', 700000, 300000, 1000000, N'Đã thanh toán');



UPDATE HOADON
SET NgayThanhToan = '2024-05-18', TinhTrangThanhToan = N'Đã thanh toán'
WHERE MaHoaDon = 'HD002';

DELETE FROM HOADON WHERE MaHoaDon = 'HD003';


SELECT * FROM ChiTietBaoCao;
SELECT * FROM HOADON;


CREATE or ALTER PROCEDURE InsertSanh
    @TenSanh NVARCHAR(255),
    @DonGia DECIMAL(18, 2),
    @DiaChi NVARCHAR(255),
	@LoaiSanh NVARCHAR(255)
AS
BEGIN
    -- Declare a variable to store the new MaSanh
    DECLARE @NewMaSanh INT;
    
    -- Get the maximum MaSanh from the table and add 1 to it
    SELECT @NewMaSanh = ISNULL(MAX(MaSanh), 0) + 1
    FROM [SE104].[dbo].[SANH];
    
    -- Insert the new record into the SANH table
    INSERT INTO [SE104].[dbo].[SANH] (MaSanh, TenSanh, DonGia, DiaChi, LoaiSanh)
    VALUES (@NewMaSanh, @TenSanh, @DonGia, @DiaChi, @LoaiSanh);
    
    -- Optionally, return the new MaSanh
    SELECT @NewMaSanh AS NewMaSanh;
END;

CREATE PROCEDURE ThemDichVu (
    @TenDichVu NVARCHAR(255),
    @DonGia DECIMAL(13, 2)
)
AS
BEGIN
    DECLARE @MaDichVu INT;

    -- Tìm số lượng bản ghi hiện có trong bảng DICHVU
    SELECT @MaDichVu = COUNT(*) + 1 FROM DICHVU;

    -- Thêm dịch vụ mới vào bảng DICHVU
    INSERT INTO DICHVU (MaDichVu, TenDichVu, DonGia)
    VALUES (@MaDichVu, @TenDichVu, @DonGia);
    
    -- Trả về MaDichVu của dịch vụ vừa được thêm vào
    SELECT @MaDichVu AS MaDichVu;
END;



IF EXISTS (
    SELECT 1
    FROM [SE104].[dbo].[CA]
    WHERE [ThoiGianBatDau] > DATEADD(DAY, 2, GETDATE())
)
BEGIN
    SELECT [MaCa], [ThoiGianBatDau], [ThoiGianKetThuc]
    FROM [SE104].[dbo].[CA]
    WHERE [ThoiGianBatDau] > DATEADD(DAY, 2, GETDATE())
END
ELSE
BEGIN
    SELECT N'Full Lịch' AS Result
END

CREATE  or ALTER PROCEDURE InsertHoaDon
    @MaTiecCuoi CHAR(10),
    @NgayThanhToan DATE,
    @TongTienBan INT,
    @TongTienThucDon INT,
    @TongTienHoaDon INT,
    @TinhTrangThanhToan NVARCHAR(100),
    @TienPhat INT
AS
BEGIN
    DECLARE @LastId INT;

    -- Tìm MaHoaDon lớn nhất trong bảng
    SELECT @LastId = ISNULL(MAX(MaHoaDon), 0) FROM HOADON;

    -- Tăng giá trị MaHoaDon lên 1
    SET @LastId = @LastId + 1;

    -- Thêm bản ghi mới vào bảng HOADON
    INSERT INTO HOADON (MaHoaDon, MaTiecCuoi, NgayThanhToan, TongTienBan, TongTienThucDon, TongTienHoaDon, TinhTrangThanhToan, TienPhat)
    VALUES (@LastId, @MaTiecCuoi, @NgayThanhToan, @TongTienBan, @TongTienThucDon, @TongTienHoaDon, @TinhTrangThanhToan, @TienPhat);
END;


CREATE or alter PROCEDURE XoaTiecCuoi
    @MaTiecCuoi CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa dữ liệu liên quan trong bảng HOADON
    DELETE FROM HOADON
    WHERE MaTiecCuoi = @MaTiecCuoi;

    -- Xóa dữ liệu trong bảng TIECCUOI
    DELETE FROM TIECCUOI
    WHERE MaTiecCuoi = @MaTiecCuoi;
END

CREATE  or alter PROCEDURE sp_InsertCA
    @ThoiGianBatDau time,
    @ThoiGianKetThuc time
AS
BEGIN
    DECLARE @NewMaCa varchar(10)
    DECLARE @MaxMaCaNumber int

    -- Lấy số lớn nhất trong MaCa từ bảng
    SELECT @MaxMaCaNumber = MAX(CAST(SUBSTRING(MaCa, 4, LEN(MaCa)) AS int))
    FROM [SE104].[dbo].[CA]
    WHERE MaCa LIKE 'CA%'

    -- Tạo MaCa mới với định dạng CA005
    SET @NewMaCa = 'CA' + RIGHT('000' + CAST(@MaxMaCaNumber + 1 AS varchar), 3)

    -- Insert dữ liệu vào bảng
    INSERT INTO [SE104].[dbo].[CA] (MaCa, ThoiGianBatDau, ThoiGianKetThuc)
    VALUES (@NewMaCa, @ThoiGianBatDau, @ThoiGianKetThuc)
END