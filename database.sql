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