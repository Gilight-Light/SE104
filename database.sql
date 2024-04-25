
-- Source ở đây, ae sẽ push source code sql ở đây nhé.

---- CREATE TABLE 
Create Table TIECCUOI  (
    MaTiecCuoi CHAR(10)  PRIMARY KEY,
    MaSanh CHAR(10) NOT NULL,
    MaCa CHAR(10) NOT NULL,
    MaThucDon CHAR(10) NOT NULL,
    NgayToChuc DATE NOT NULL,
    TienDatCoc INT NOT NULL,
    SoLuongBan INT NOT NULL,
    SoLuongBanDuTru INT NOT NULL,
	UserID CHAR(10) NOT NULL
);
Create Table CA  (
    MaCa CHAR(10) PRIMARY KEY,
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThuc DATETIME NOT NULL,
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
	MaThucDon CHAR(10) primary key,
	MonKhaiVi nvarchar(100) not null,
	MonChinh1 nvarchar(100)not null,
	MonChinh2 nvarchar(100) not null,
	MonChinh3 nvarchar(100) not null,
	Lau nvarchar(100) not null,
	TrangMieng nvarchar(100) not null,
	Bia nvarchar(100) not null,
	NuocNgot nvarchar(100)not null,
	GiaThucDon money not null
);

CREATE TABLE NGUOIDUNG (
    UserID CHAR(10) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    AccountType NVARCHAR(20) NOT NULL -- Ví dụ: 'customer', 'admin'
);

Create table PHANHOI 
(
	MaPhanHoi CHAR(10)  PRIMARY KEY,
	UserID  CHAR(10)  NOT NULL,
	MaTiecCuoi CHAR(10) NOT NULL,
	NoiDung NVARCHAR(100) NOT NULL,
    NgayDanhGia DATE NOT NULL, 
	GhiChu NVARCHAR(100),
	FOREIGN KEY (UserID) REFERENCES NGUOIDUNG(UserID),
	FOREIGN KEY (MaTiecCuoi ) REFERENCES TIECCUOI(MaTiecCuoi)

);



create table HOADON 
(
 MaHoaDon Int Primary key,
 MaTiecCuoi char(10) not null,
 NgayThanhToan date not null,
 TongTienBan int not null,
 TongTienThucDon int not null,
 TongTienHoaDon int not null,
 FOREIGN KEY (MaTiecCuoi ) REFERENCES TIECCUOI(MaTiecCuoi)

)
	
CREATE TABLE SANH 
(
	MaSanh char(10) PRIMARY KEY,
	LoaiSanh nvarchar(10) NOT NULL,
	TenSanh nvarchar(100) NOT NULL,
	MaLoaiSanh nvarchar(100) NOT NULL,
	SoLuongBanToiDa INT NOT NULL,
	DonGia money NOT NULL,
	GhiChu nvarchar(100) NOT NULL
)

CREATE TABLE ChiTietBaoCao 
(
	MaCTBaoCao CHAR(10) PRIMARY KEY,
	NGAY DATE NOT NULL,
	SoLuong INT NOT NULL,
	DoanhThu INT NOT NULL,
)
CREATE TABLE BaoCaoDoanhThu 
(
	MaBaoCao CHAR(10) PRIMARY KEY,
	Thang char(20) NOT NULL,
	TongDoanhThu INT NOT NULL
)

CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY IDENTITY,
    AccountType NVARCHAR(20) NOT NULL, -- Ví dụ: 'customer', 'admin'
    CanAccessAdvancedFeatures BIT NOT NULL -- 0: Không, 1: Có
);
INSERT INTO Permissions (AccountType, CanAccessAdvancedFeatures)
VALUES 
    ('customer', 0), -- Khách hàng không có quyền truy cập các tính năng nâng cao
    ('admin', 1);    -- Quản trị viên có quyền truy cập các tính năng nâng cao
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

-- TABLE NHANVIEN 
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_MaCa
FOREIGN KEY (MaCa)
REFERENCES CA(MaCa)
	
-- TABLE ChiTietBaoCao
ALTER TABLE ChiTietBaoCao
ADD CONSTRAINT FK_MaBaoCao
FOREIGN KEY (MaBaoCao)
REFERENCES BaoCaoDoanhThu(MaBaoCao)

-- Table HoaDon
ALTER TABLE HOADON
ALTER COLUMN TongTienHoaDon INT NULL;
GO

------------ INSERT INTO DATA ----------------------------

-- TABLE SANH
INSERT INTO SANH (MaSanh, LoaiSanh, TenSanh, MaLoaiSanh, SoLuongBanToiDa, DonGia, GhiChu)
VALUES
    ('S001', 'Loai A', 'Tên Sảnh A', 'Kim Cương', 500, 50000000, 'Không'),
    ('S002', 'Loai B', 'Tên Sảnh B', 'Bạch Kim', 450, 45000000, 'Không'),
    ('S003', 'Loai C', 'Tên Sảnh C', 'Vàng', 400, 40000000, 'Không'),
    ('S004', 'Loai D', 'Tên Sảnh D', 'Bạc', 350, 35000000, 'Không'),
    ('S005', 'Loai E', 'Tên Sảnh E', 'Đồng', 300, 30000000, 'Không');

	
-- TABLE CA
INSERT INTO CA (MaCa, ThoiGianBatDau, ThoiGianKetThuc)
VALUES 
    ('Ca001', '2024-05-01 08:00:00', '2024-05-01 12:00:00'),
    ('Ca002', '2024-05-01 13:00:00', '2024-05-01 17:00:00'),
    ('Ca003', '2024-05-02 08:00:00', '2024-05-02 12:00:00'),
    ('Ca004', '2024-05-02 13:00:00', '2024-05-02 17:00:00'),
    ('Ca005', '2024-05-03 08:00:00', '2024-05-03 12:00:00');


--- TABLE THUCDON
INSERT INTO THUCDON VALUES(N'TD001',N'Chả Giò Rế Hà Nội',N'Gà Ấp Chảo + Bánh Bao',N'Dê Hấp Lá Tía Tô',N'Tôm Sông Rang Muối',N'Lẩu Thái Hải Sản',N'Thanh Nhiệt Sâm Sâm',N'Heniken',N'Pepsi',N'2000000')
INSERT INTO THUCDON VALUES(N'TD002',N'Suop Cua Gà Xé',N'Gà Bó Xôi',N'Bò Nấu Đậu + Bánh Mì',N'Vịt Quay Bắc Kinh',N'Lẩu Nắm Hải Sản',N'Chè Hạt Sen',N'Tiger Bạc',N'Trà Xanh',N'1800000')
INSERT INTO THUCDON VALUES(N'TD003',N'Gỏi Gó Sen Tôm Thit',N'Gà Hấp Hành + Xôi',N'Cá Điêu Hồng Chưng Tương',N'Chim Cút Roti + Bánh Mì',N'Lẩu Thái Hải Sản',N'Chè Hạt Sen',N'Heniken',N'Cocacola',N'2000000')
INSERT INTO THUCDON VALUES(N'TD004',N'Suop Hải Sản Nấm Tuyết',N'Gà Nấu Lagu + Bánh Mì',N'Cá Điêu Hồng Hấp HongKong',N'Gà Bó Xôi',N'Lẩu Cua Đồng',N'Rau Câu Ngũ Sắc',N'Tiger',N'Pepsi',N'1800000')
INSERT INTO THUCDON VALUES(N'TD005',N'Chả Giò Venus',N'Chim Cút Roti + Bánh Mì',N'Tôm Sông Rang Muối',N'Cá Điêu Hồng Chưng Tương',N'Lẩu Cá Bớp',N'Chè Khúc Bạch',N'Heniken',N'Pepsi',N'2000000')

-- PROCEDURE
-- Tạo procedure thêm, cập nhật, và xóa loại sảnh
CREATE PROCEDURE QuanLyLoaiSanh
    @MaSanh CHAR(10),
    @TenSanh NVARCHAR(100),
    @MaLoaiSanh NVARCHAR(100),
    @SoLuongBanToiDa INT,
    @DonGia MONEY,
    @GhiChu NVARCHAR(100),
    @Action NVARCHAR(10)
AS
BEGIN
    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO SANH (MaSanh, TenSanh, MaLoaiSanh, SoLuongBanToiDa, DonGia, GhiChu)
        VALUES (@MaSanh, @TenSanh, @MaLoaiSanh, @SoLuongBanToiDa, @DonGia, @GhiChu);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE SANH
        SET TenSanh = @TenSanh,
            MaLoaiSanh = @MaLoaiSanh,
            SoLuongBanToiDa = @SoLuongBanToiDa,
            DonGia = @DonGia,
            GhiChu = @GhiChu
        WHERE MaSanh = @MaSanh;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM SANH WHERE MaSanh = @MaSanh;
    END
END;
GO
-- Tạo procedure cho thêm, chỉnh sửa, và xóa thực đơn
CREATE PROCEDURE QuanLyThucDon
    @MaThucDon CHAR(10),
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

--- TABLE NGUOIDUNG
INSERT INTO NGUOIDUNG (UserID, FullName, Email, PasswordHash, AccountType)
VALUES 
    ('KH001', N'Nguyễn Văn Khánh', 'khanh@example.com', 'hashed_password1', 'customer'),
    ('KH002', N'Trần Thị Hương', 'huong@example.com', 'hashed_password2', 'customer'),
    ('KH003', N'Lê Minh Anh', 'anh@example.com', 'hashed_password3', 'customer'),
    ('KH004', N'Phạm Quốc Trung', 'trung@example.com', 'hashed_password4', 'customer'),
    ('KH005', N'Huỳnh Thị Lan', 'lan@example.com', 'hashed_password5', 'customer'),
    ('AD001', N'Admin', 'admin@example.com', 'hashed_admin_password', 'admin');

-- TABLE TIECCUOI
INSERT INTO TIECCUOI (MaTiecCuoi, MaSanh, MaCa, MaThucDon, NgayToChuc, TienDatCoc, SoLuongBan, SoLuongBanDuTru, UserID)
VALUES 
    ('TC001', 'S001', 'Ca001', 'TD001', '2024-05-01', 5000000, 10, 2, 'KH001'),
    ('TC002', 'S002', 'Ca002', 'TD002', '2024-05-02', 6000000, 15, 3, 'KH002'),
    ('TC003', 'S003', 'Ca001', 'TD003', '2024-05-03', 7000000, 20, 4, 'KH003'),
    ('TC004', 'S002', 'Ca002', 'TD002', '2024-05-04', 8000000, 25, 5, 'KH004'),
    ('TC005', 'S001', 'Ca001', 'TD001', '2024-05-05', 9000000, 30, 6, 'KH005');


-- TABLE NHANVIEN
INSERT INTO NHANVIEN (MaNhanVien, MaCa, TenNhanVien, SoDienThoai, ChucVu)
VALUES 
    ('NV001', 'Ca001', N'Trần Văn A', '1234567890', N'Quản lý'),
    ('NV002', 'Ca002', N'Nguyễn Thị B', '0987654321', N'Nhân viên bán hàng'),
    ('NV003', 'Ca003', N'Lê Văn C', '0123456789', N'Nhân viên phục vụ'),
    ('NV004', 'Ca004', N'Phạm Thị D', '0987123456', N'Nhân viên pha chế'),
    ('NV005', 'Ca005', N'Huỳnh Văn E', '0123987654', N'Nhân viên dọn dẹp');


-- TABLE PHANHOI
INSERT INTO PHANHOI (MaPhanHoi, UserID, MaTiecCuoi, NoiDung, NgayDanhGia, GhiChu)
VALUES 
    ('PH1', 'KH001', 'TC004', N'Dịch vụ tốt, đồ ăn ngon, không gian thoáng mát', '2023-01-10', N'NONE'),
    ('PH2', 'KH002', 'TC001', N'Phục vụ chu đáo, thực đơn đặc sắc', '2024-01-12', N'NONE'),
    ('PH3', 'KH003', 'TC005', N'Không gian nhà hàng rộng rãi, sang trọng, được bài trí đẹp mắt và rất phù hợp cho tiệc cưới', '2023-11-22', N'NONE'),
    ('PH4', 'KH004', 'TC002', N'Nhân viên phục vụ nhiệt tình, chu đáo và luôn sẵn sàng hỗ trợ chúng tôi trong suốt quá trình tổ chức tiệc', '2023-04-09', N'NONE'),
    ('PH5', 'KH005', 'TC003', N'Một địa điểm tuyệt vời để tổ chức tiệc cưới', '2023-10-20', N'NONE');

-- TABLE HOADON
INSERT INTO HOADON (MaHoaDon, MaTiecCuoi, NgayThanhToan, TongTienBan, TongTienThucDon, TongTienHoaDon)
VALUES 
    (1, 'TC001', '2023-01-10', 5000000, 5000000, 5500000),
    (2, 'TC002', '2024-01-12', 7000000, 5000000, 7500000),
    (3, 'TC003', '2023-11-22', 6000000, 5000000, 6500000),
    (4, 'TC004', '2023-01-13', 8000000, 5000000, 8500000),
    (5, 'TC005', '2024-01-15', 6000000, 5000000, 6500000);


-- TABLE ChiTietBaoCao
INSERT INTO ChiTietBaoCao (MaCTBaoCao, NGAY, SoLuong, DoanhThu)
VALUES 
    ('CTBC001', '2024-01-01', 10, 1000000),
    ('CTBC002', '2024-01-02', 20, 2000000),
    ('CTBC003', '2024-01-03', 30, 3000000),
    ('CTBC004', '2024-01-04', 40, 4000000),
    ('CTBC005', '2024-01-05', 50, 5000000);

-- TABLE BaoCaoDoanhThu
INSERT INTO BaoCaoDoanhThu (MaBaoCao, Thang, TongDoanhThu)
VALUES 
    ('BC001', 'Tháng 1', 15000000),
    ('BC002', 'Tháng 2', 25000000),
    ('BC003', 'Tháng 3', 35000000),
    ('BC004', 'Tháng 4', 45000000),
    ('BC005', 'Tháng 5', 55000000);

-- PROCEDURE
-- Tạo procedure thêm, cập nhật, và xóa loại sảnh
CREATE PROCEDURE QuanLyLoaiSanh
    @MaSanh CHAR(10),
    @TenSanh NVARCHAR(100),
    @MaLoaiSanh NVARCHAR(100),
    @SoLuongBanToiDa INT,
    @DonGia MONEY,
    @GhiChu NVARCHAR(100),
    @Action NVARCHAR(10)
AS
BEGIN
    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO SANH (MaSanh, TenSanh, MaLoaiSanh, SoLuongBanToiDa, DonGia, GhiChu)
        VALUES (@MaSanh, @TenSanh, @MaLoaiSanh, @SoLuongBanToiDa, @DonGia, @GhiChu);
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE SANH
        SET TenSanh = @TenSanh,
            MaLoaiSanh = @MaLoaiSanh,
            SoLuongBanToiDa = @SoLuongBanToiDa,
            DonGia = @DonGia,
            GhiChu = @GhiChu
        WHERE MaSanh = @MaSanh;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM SANH WHERE MaSanh = @MaSanh;
    END
END;
GO
-- Tạo procedure cho thêm, chỉnh sửa, và xóa thực đơn
CREATE PROCEDURE QuanLyThucDon
    @MaThucDon CHAR(10),
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

--- Tao Procedure them, xoa sua Tiec Cuoi => thay doi them, xoa sua HoaDon
-- Insert TiecCuoi
CREATE PROCEDURE InsertHoaDon
    @MaTiecCuoi CHAR(10),
    @NgayToChuc DATE,
    @SoLuongBan INT,
    @MaSanh CHAR(10),
    @MaThucDon CHAR(10),
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