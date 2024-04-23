<<<<<<< HEAD
-- Source ở đây, ae sẽ push source code sql ở đây nhé.

---- CREATE TABLE 
Create Table TIECCUOI IF NOT EXISTS (
    MaTiecCuoi CHAR(10)  PRIMARY KEY,
    MaSanh CHAR(10) NOT NULL,
    MaCa CHAR(10) NOT NULL,
    MaThucDon CHAR(10) NOT NULL,
    NgayToChuc DATE NOT NULL,
    TienDatCoc INT NOT NULL,
    SoLuongBan INT NOT NULL,
    SoLuongBanDuTru INT NOT NULL,
);

Create Table CA IF NOT EXISTS (
    MaCa CHAR(10) PRIMARY KEY,
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThuc DATETIME NOT NULL,
);

Create Table NHANVIEN IF NOT EXISTS (
    MaNhanVien CHAR(10) PRIMARY KEY,
    MaCa CHAR(10) NOT NULL,
    TenNhanVien NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(10) NOT NULL,
    ChucVu NVARCHAR(100) NOT NULL
);
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

GO

------------ INSERT INTO DATA ----------------------------


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

GO
=======

create database QUANLYTIECCUOI
Create table ThucDon
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
)
insert into ThucDon values(N'TĐ 1',N'Chả Giò Rế Hà Nội',N'Gà Ấp Chảo + Bánh Bao',N'Dê Hấp Lá Tía Tô',N'Tôm Sông Rang Muối',N'Lẩu Thái Hải Sản',N'Thanh Nhiệt Sâm Sâm',N'Heniken',N'Pepsi',N'2000000')
insert into ThucDon values(N'TĐ 2',N'Suop Cua Gà Xé',N'Gà Bó Xôi',N'Bò Nấu Đậu + Bánh Mì',N'Vịt Quay Bắc Kinh',N'Lẩu Nắm Hải Sản',N'Chè Hạt Sen',N'Tiger Bạc',N'Trà Xanh',N'1800000')
insert into ThucDon values(N'TĐ 3',N'Gỏi Gó Sen Tôm Thit',N'Gà Hấp Hành + Xôi',N'Cá Điêu Hồng Chưng Tương',N'Chim Cút Roti + Bánh Mì',N'Lẩu Thái Hải Sản',N'Chè Hạt Sen',N'Heniken',N'Cocacola',N'2000000')
insert into ThucDon values(N'TĐ 4',N'Suop Hải Sản Nấm Tuyết',N'Gà Nấu Lagu + Bánh Mì',N'Cá Điêu Hồng Hấp HongKong',N'Gà Bó Xôi',N'Lẩu Cua Đồng',N'Rau Câu Ngũ Sắc',N'Tiger',N'Pepsi',N'1800000')
insert into ThucDon values(N'TĐ 5',N'Chả Giò Venus',N'Chim Cút Roti + Bánh Mì',N'Tôm Sông Rang Muối',N'Cá Điêu Hồng Chưng Tương',N'Lẩu Cá Bớp',N'Chè Khúc Bạch',N'Heniken',N'Pepsi',N'2000000')

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

)

INSERT INTO PHANHOI VALUES (N'PH1', N'KH1', N'TC4', N'dịch vụ tốt, đồ ăn ngon, không gian thoáng mát', N'10-01-2023',N'NONE')
INSERT INTO PHANHOI VALUES (N'PH2', N'KH2', N'TC1', N'phục vụ chu đáo,thực đơn đặc sắc', N'12-1-2024',N'NONE')
INSERT INTO PHANHOI VALUES (N'PH3', N'KH3', N'TC5', N'Không gian nhà hàng rộng rãi, sang trọng, được bài trí đẹp mắt và rất phù hợp cho tiệc cưới', N'22-11-2023', N'NONE')
INSERT INTO PHANHOI VALUES (N'PH4', N'KH4', N'TC2', N'Nhân viên phục vụ nhiệt tình, chu đáo và luôn sẵn sàng hỗ trợ chúng tôi trong suốt quá trình tổ chức tiệc', N'09-04-2023', N'NONE')
INSERT INTO PHANHOI VALUES (N'PH5', N'KH5', N'TC3', N'một địa điểm tuyệt vời để tổ chức tiệc cưới', N'20-10-2023',N'NONE')

create table HoaDon(

 MaHoaDon char(10) primary key,
 MaTiecCuoi char(10) not null,
 NgayThanhToan date not null,
 TongTienBan int not null,
 TongTienHoaDon int not null,
 FOREIGN KEY (MaTiecCuoi ) REFERENCES TIECCUOI(MaTiecCuoi)

)
INSERT INTO HoaDon VALUES
    (N'HD1', N'TC1', N'10-01-2023', 5000000, 5500000),
    (N'HD2', N'TC2', N'12-1-2024', 7000000, 7500000),
    (N'HD3', N'TC3', N'22-11-2023', 6000000, 6500000),
    (N'HD4', N'TC4', N'13-01-2023', 8000000, 8500000),
    (N'HD5', N'TC5', N'15-1-2024', 6000000, 6500000);
>>>>>>> 69046701f1e6223057925776ca5f84b1d9e3c866
