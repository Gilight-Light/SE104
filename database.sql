<<<<<<< HEAD
-- Source ở đây, ae sẽ push source code sql ở đây nhé.
create database  QUANLYTIECCUOI 
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
	MaThucDon varchar(100) primary key,
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

Create table PHANHOI 
(
	MaPhanHoi CHAR(10)  PRIMARY KEY,
	MaKhachHang CHAR(10) NOT NULL,
	MaTiecCuoi CHAR(10) NOT NULL,
	NoiDung NVARCHAR(100) NOT NULL,
    NgayDanhGia DATE NOT NULL, 
	GhiChu NVARCHAR(100),
	FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG (MaKhachHang),
	FOREIGN KEY (MaTiecCuoi ) REFERENCES TIECCUOI(MaTiecCuoi)

);

create table HOADON 
(
 MaHoaDon char(10) primary key,
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

CREATE TABLE NGUOIDUNG (
    UserID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    AccountType NVARCHAR(20) NOT NULL -- Ví dụ: 'customer', 'admin'
);

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
ALTER TABLE TIECCUOI
ADD FK_MaSanh
FOREIGN KEY (MaSanh)
REFERENCES SANH(MaSanh)

ALTER TABLE TIECCUOI
ADD FK_MaCa
FOREIGN KEY (MaCa)
REFERENCES CA(MaCa)

ALTER TABLE TIECCUOI
ADD FK_MaThucDon
FOREIGN KEY (MaThucDon)
REFERENCES THUCDON(MaThucDon)

-- TABLE NHANVIEN 
ALTER TABLE NHANVIEN
ADD FK_MaCa
FOREIGN KEY (MaCa)
REFERENCES CA(MaCa)
	
-- TABLE ChiTietBaoCao
ALTER TABLE ChiTietBaoCao
ADD FK_MaBaoCao
FOREIGN KEY (MaBaoCao)
REFERENCES BaoCaoDoanhThu(MaBaoCao)
GO

------------ INSERT INTO DATA ----------------------------

--- TABLE SANH
insert into SANH (MaSanh, LoaiSanh, TenSanh, SoLuongBanToiDa, DonGiaToiThieu, GhiChu)
	values
		('S01','Loai A','Kim Cương','500','50000000','Không'),
		('S02','Loai B','Bạch Kim','450','45000000','Không'),
		('S03','Loai C','Vàng','400','40000000','Không'),
		('S04','Loai D','Bạc','350','35000000','Không'),
		('S05','Loai E','Đồng','300','30000000','Không');
--- TABLE TIECCUOI
INSERT INTO TIECCUOI (MaTiecCuoi, MaSanh, MaCa, MaThucDon, NgayToChuc, TienDatCoc, SoLuongBan, SoLuongBanDuTru)
    VALUES 
        ('TC001', 'S001', 'C001', 'TD001', '2024-05-01', 5000000, 10, 2),
        ('TC002', 'S002', 'C002', 'TD002', '2024-05-02', 6000000, 15, 3),
        ('TC003', 'S003', 'C001', 'TD003', '2024-05-03', 7000000, 20, 4),
        ('TC004', 'S002', 'C002', 'TD002', '2024-05-04', 8000000, 25, 5),
        ('TC005', 'S001', 'C001', 'TD001', '2024-05-05', 9000000, 30, 6);

--- TABLE CA
 INSERT INTO CA (MaCa, ThoiGianBatDau, ThoiGianKetThuc)
    VALUES 
        ('Ca001', '2024-05-01 08:00:00', '2024-05-01 12:00:00'),
        ('Ca002', '2024-05-01 13:00:00', '2024-05-01 17:00:00'),
        ('Ca003', '2024-05-02 08:00:00', '2024-05-02 12:00:00'),
        ('Ca004', '2024-05-02 13:00:00', '2024-05-02 17:00:00'),
        ('Ca005', '2024-05-03 08:00:00', '2024-05-03 12:00:00');

--- TABLE NHANVIEN
INSERT INTO NHANVIEN (MaNhanVien, MaCa, TenNhanVien, SoDienThoai, ChucVu)
    VALUES 
        ('NV001', 'Ca001', N'Trần Văn A', '1234567890', N'Quản lý'),
        ('NV002', 'Ca002', N'Nguyễn Thị B', '0987654321', N'Nhân viên bán hàng'),
        ('NV003', 'Ca003', N'Lê Văn C', '0123456789', N'Nhân viên phục vụ'),
        ('NV004', 'Ca004', N'Phạm Thị D', '0987123456', N'Nhân viên pha chế'),
        ('NV005', 'Ca005', N'Huỳnh Văn E', '0123987654', N'Nhân viên dọn dẹp');

--- TABLE THUCDON
INSERT INTO THUCDON VALUES(N'TĐ 1',N'Chả Giò Rế Hà Nội',N'Gà Ấp Chảo + Bánh Bao',N'Dê Hấp Lá Tía Tô',N'Tôm Sông Rang Muối',N'Lẩu Thái Hải Sản',N'Thanh Nhiệt Sâm Sâm',N'Heniken',N'Pepsi',N'2000000')
INSERT INTO THUCDON VALUES(N'TĐ 2',N'Suop Cua Gà Xé',N'Gà Bó Xôi',N'Bò Nấu Đậu + Bánh Mì',N'Vịt Quay Bắc Kinh',N'Lẩu Nắm Hải Sản',N'Chè Hạt Sen',N'Tiger Bạc',N'Trà Xanh',N'1800000')
INSERT INTO THUCDON VALUES(N'TĐ 3',N'Gỏi Gó Sen Tôm Thit',N'Gà Hấp Hành + Xôi',N'Cá Điêu Hồng Chưng Tương',N'Chim Cút Roti + Bánh Mì',N'Lẩu Thái Hải Sản',N'Chè Hạt Sen',N'Heniken',N'Cocacola',N'2000000')
INSERT INTO THUCDON VALUES(N'TĐ 4',N'Suop Hải Sản Nấm Tuyết',N'Gà Nấu Lagu + Bánh Mì',N'Cá Điêu Hồng Hấp HongKong',N'Gà Bó Xôi',N'Lẩu Cua Đồng',N'Rau Câu Ngũ Sắc',N'Tiger',N'Pepsi',N'1800000')
INSERT INTO THUCDON VALUES(N'TĐ 5',N'Chả Giò Venus',N'Chim Cút Roti + Bánh Mì',N'Tôm Sông Rang Muối',N'Cá Điêu Hồng Chưng Tương',N'Lẩu Cá Bớp',N'Chè Khúc Bạch',N'Heniken',N'Pepsi',N'2000000')

--- TABLE PHANHOI
INSERT INTO PHANHOI VALUES (N'PH1', N'KH1', N'TC4', N'dịch vụ tốt, đồ ăn ngon, không gian thoáng mát', N'10-01-2023',N'NONE')
INSERT INTO PHANHOI VALUES (N'PH2', N'KH2', N'TC1', N'phục vụ chu đáo,thực đơn đặc sắc', N'12-1-2024',N'NONE')
INSERT INTO PHANHOI VALUES (N'PH3', N'KH3', N'TC5', N'Không gian nhà hàng rộng rãi, sang trọng, được bài trí đẹp mắt và rất phù hợp cho tiệc cưới', N'22-11-2023', N'NONE')
INSERT INTO PHANHOI VALUES (N'PH4', N'KH4', N'TC2', N'Nhân viên phục vụ nhiệt tình, chu đáo và luôn sẵn sàng hỗ trợ chúng tôi trong suốt quá trình tổ chức tiệc', N'09-04-2023', N'NONE')
INSERT INTO PHANHOI VALUES (N'PH5', N'KH5', N'TC3', N'một địa điểm tuyệt vời để tổ chức tiệc cưới', N'20-10-2023',N'NONE')

--- TABLE HOADON
INSERT INTO HOADON VALUES
    (N'HD1', N'TC1', N'10-01-2023', 5000000, 5500000),
    (N'HD2', N'TC2', N'12-1-2024', 7000000, 7500000),
    (N'HD3', N'TC3', N'22-11-2023', 6000000, 6500000),
    (N'HD4', N'TC4', N'13-01-2023', 8000000, 8500000),
    (N'HD5', N'TC5', N'15-1-2024', 6000000, 6500000);

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


>>>>>>> 69046701f1e6223057925776ca5f84b1d9e3c866
