
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
	GiaThucDon money not null
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
 MaHoaDon Int Primary key,
 MaTiecCuoi char(10) not null,
 NgayThanhToan date not null,
 TongTienBan int not null,
 TongTienThucDon int not null,
 TongTienHoaDon int not null,

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
	MaCTBaoCao INT PRIMARY KEY,
	NGAY DATE NOT NULL,
	SoLuong INT NOT NULL,
	DoanhThu INT NOT NULL,
)
CREATE TABLE BaoCaoDoanhThu 
(
	MaBaoCao INT PRIMARY KEY,
	Thang char(20) NOT NULL,
	TongDoanhThu INT NOT NULL
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
INSERT INTO THUCDON VALUES(1,N'Chả Giò Rế Hà Nội',N'Gà Ấp Chảo + Bánh Bao',N'Dê Hấp Lá Tía Tô',N'Tôm Sông Rang Muối',N'Lẩu Thái Hải Sản',N'Thanh Nhiệt Sâm Sâm',N'Heniken',N'Pepsi',N'2000000')
INSERT INTO THUCDON VALUES(2,N'Suop Cua Gà Xé',N'Gà Bó Xôi',N'Bò Nấu Đậu + Bánh Mì',N'Vịt Quay Bắc Kinh',N'Lẩu Nắm Hải Sản',N'Chè Hạt Sen',N'Tiger Bạc',N'Trà Xanh',N'1800000')
INSERT INTO THUCDON VALUES(3,N'Gỏi Gó Sen Tôm Thit',N'Gà Hấp Hành + Xôi',N'Cá Điêu Hồng Chưng Tương',N'Chim Cút Roti + Bánh Mì',N'Lẩu Thái Hải Sản',N'Chè Hạt Sen',N'Heniken',N'Cocacola',N'2000000')
INSERT INTO THUCDON VALUES(4,N'Suop Hải Sản Nấm Tuyết',N'Gà Nấu Lagu + Bánh Mì',N'Cá Điêu Hồng Hấp HongKong',N'Gà Bó Xôi',N'Lẩu Cua Đồng',N'Rau Câu Ngũ Sắc',N'Tiger',N'Pepsi',N'1800000')
INSERT INTO THUCDON VALUES(5,N'Chả Giò Venus',N'Chim Cút Roti + Bánh Mì',N'Tôm Sông Rang Muối',N'Cá Điêu Hồng Chưng Tương',N'Lẩu Cá Bớp',N'Chè Khúc Bạch',N'Heniken',N'Pepsi',N'2000000')


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
    ('TC001', 1, 'Ca001', 1, '2024-05-01', 5000000, 1, 10, 2, 'KH001'),
    ('TC002', 2, 'Ca002', 2, '2024-05-02', 6000000, 2, 15, 3, 'KH002'),
    ('TC003', 3, 'Ca001', 3, '2024-05-03', 7000000, 3, 20, 4, 'KH003'),
    ('TC004', 2, 'Ca002', 2, '2024-05-04', 8000000, 4, 25, 5, 'KH004'),
    ('TC005', 1, 'Ca001', 1, '2024-05-05', 9000000, 5, 30, 6, 'KH005');

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
--Procdure : Nếu NgayThanhToan (HoaDon) > NgayThanhToan (ThanhToan) => TienPhat (ThanhToan) = 10% TongTien(HoaDon)
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
--Tạo Procdure : Truyền : UserID => Trả về : Tên Người Dùng(NGUOIDUNG) ,Tên Sảnh(SANH), Thời Gian (Ca), Tên Thực Đơn(THUCDON), Tên Dịch Vụ(DICHVU)

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
CREATE PROCEDURE XoaDichVu
    @MaDichVu INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa các liên kết từ bảng TIECCUOI
    DELETE FROM TIECCUOI WHERE MaDichVu = @MaDichVu;

    -- Xóa dịch vụ từ bảng DICHVU
    DELETE FROM DICHVU WHERE MaDichVu = @MaDichVu;
    
    PRINT 'Đã xóa dịch vụ thành công.';
END


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
    @UserID CHAR(10)
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
            UserID
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
            @UserID
        );

        -- Trả về thông báo thành công
        SELECT 'Đặt Thành Công' AS KetQua;
    END
END;
---Procdure Xóa SANH =>  Xóa các bảng ràng buộc liên quan luôn ( TIECCUOI )
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
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        SELECT @ErrorMessage AS KetQua;
    END CATCH
END;
---Procdure Xóa THUCDON => Xóa các bảng ràng buộc liên quan ( TIECCUOI)
CREATE PROCEDURE sp_XoaThucDon
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
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        SELECT @ErrorMessage AS KetQua;
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
