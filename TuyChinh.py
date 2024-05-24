from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
import random
from decimal import Decimal
import os
from datetime import datetime, timedelta
tuychinh_bp = Blueprint('tuychinh_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
cursor = conn.cursor()
@tuychinh_bp.route('/')
def tuychinh():
    sql_query = """
        EXEC GetAllInvoiceDetails;
    """
    sql_query_sanh =  """
        SELECT * FROM SANH
    """
    
    sql_query_dichvu =  """
        SELECT * FROM DICHVU
    """
    
    sql_query_thucdon =  """
        SELECT * FROM THUCDON
    """

    sql_query_hoadon =  """
        SELECT * FROM HOADON
    """
    sql_query_baocao = """
        SELECT * FROM ChiTietBaoCao
    """

    sql_query_ca = """
        SELECT * FROM CA
    """
    # Thực thi câu lệnh SQL với tham số
    # Khách Hàng
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    khachhang = [{'HoTen': str(row[0]), 'TenDangNhap': str(row[1]),\
              'SoDienThoai': str(row[2]), 'MaHoaDon': str(row[3]),'TongTienThanhToan': str(row[4]),\
                'NgayThanhToan': str(row[5]),'TinhTrangThanhToan': str(row[6]), 'MaTiecCuoi': str(row[7]), 'TienPhat': str(row[8]),\
                    'MaSanh': str(row[9]), 'MaThucDon': str(row[10]), 'MaDichVu': str(row[11]), 'TienCoc': str(row[12])} \
             for row in data_from_db]
    times = []
    cursor.execute("SELECT ThoiGianBatDau FROM CA ")
    ca = cursor.fetchall()
    conn.commit()
    for row in ca:
        times.append(row[0])
    # Sảnh
    cursor.execute(sql_query_sanh)
    data_from_db_sanh = cursor.fetchall()
    sanh = [{'MaSanh': str(row[0]), 'TenSanh': str(row[1]),\
              'DonGia': str(row[2]), 'DiaChi': str(row[3]), 'LoaiSanh': str(row[4]), 'SoBan': str(random.choice(list(range(35,70,5))))} \
             for row in data_from_db_sanh]

    # Dịch Vụ
    cursor.execute(sql_query_dichvu)
    data_from_db_dichvu = cursor.fetchall()
    dichvu = [{'MaDichVu': str(row[0]), 'TenDichVu': str(row[1]),'DonGia': str(row[2])} \
             for row in data_from_db_dichvu]
    
    # Thực Đơn
    cursor.execute(sql_query_thucdon)
    data_from_db_ThucDon = cursor.fetchall()
    thucdon = [{'MaThucDon': str(row[0]), 'TenThucDon': str(row[10]),\
              'MonKhaiVi': str(row[1]), 'MonChinh': str(row[2]) + ' - ' + str(row[3])+ ' - ' + str(row[4])+ ' - ' + str(row[5]),\
                'MonTrangMieng': str(row[6]),'ThucUong': str(row[7]) + ' - ' + str(row[8]),\
                    'DonGia': str(row[9])} \
             for row in data_from_db_ThucDon]
    
    # Báo Cáo Thống Kê
    cursor.execute(sql_query_baocao)
    data_from_db_baocao = cursor.fetchall()
    baocao = [{'MaBaoCao': str(row[0]), 'Ngay': str(row[1]),'TongDoanhThu': int(row[3])*10, 'TienThu':int(row[4])*10, 'TienNo': int(row[5])*10} \
             for row in data_from_db_baocao]
    
    # CA
    cursor.execute(sql_query_ca)
    data_from_db_ca = cursor.fetchall()
    ca = [{'MaCa': str(row[0]), 'ThoiGianBatDau': str(row[1]), 'ThoiGianKetThuc': str(row[2])} \
          for row in data_from_db_ca]
    # Đóng kết nối
    
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber']
    }
    today = datetime.today()
    dates = [(today + timedelta(days=i)).strftime('%Y-%m-%d') for i in range(31)]
    
    return render_template('TuyChinh/index.html',khachhang = khachhang, user = session['userid'], info = info, \
                           sanh = sanh, dichvu = dichvu, \
                            thucdon = thucdon, baocao =baocao, ca = ca, times= times, dates= dates) 


## Chua xu ly
@tuychinh_bp.route('/XoaTiecCuoi', methods = ["POST"])
def XoaTiecCuoi():
    data = request.get_json()
    MaTiecCuoi = str(data.get('MaTiecCuoi'))
    sql_query = """
        exec XoaTiecCuoi @MaTiecCuoi = ?
    """
    cursor.execute(sql_query, (MaTiecCuoi))
    conn.commit()
    
    print('Xoa Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/SuaTiecCuoi', methods = ["POST"])
def SuaTiecCuoi():
    TenKhachHang = str(request.form.get('TenKhachHang'))
    NgayThanhToan = str(request.form.get('NgayThanhToan'))
    MaSanh = int(request.form.get('MaSanh'))
    MaDichVu = int(request.form.get('MaDichVu'))
    MaThucDon = int(request.form.get('MaThucDon'))
    MaCa = request.form.get('ThoiGian')
    TienCoc = str(request.form.get('TienCoc'))
    sql_query = """
        update TIECCUOI SET MaSanh = 5 , MaCa = 'Ca003', MaThucDon = 4, TienDatCoc = 10000, MaDichVu = 5, NgayToChuc = '2024-05-24' WHERE MaTiecCuoi = 'TC003'
    """
    # cursor.execute('SELECT UserID FROM NGUOIDUNG WHERE FullName = ?')
    # cursor.execute(sql_query, (TenKhachHang))
    # UserID = str(cursor.fetchone()[0])
    # cursor.execute('SELECT MaCa FROM CA WHERE ThoiGianBatDau = ?')
    # MaCa = str(cursor.fetchone()[0])
    cursor.execute(sql_query)
    conn.commit()
    
    print('Xoa Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/managesanh', methods = ["POST"])
def Themsanh():
    TenSanh = str(request.form.get('TenSanh'))
    LoaiSanh = str(request.form.get('LoaiSanh'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    DiaChi = str(request.form.get('DiaChi'))
    img = request.files['image']
    sql_query = """
        EXEC InsertSanh @TenSanh = ?, @DonGia = ?, @DiaChi = ?, @LoaiSanh;
    """
    cursor.execute(sql_query, (TenSanh,DonGia,DiaChi,LoaiSanh))
    conn.commit()
    sql_query_name = """ 
        SELECT TOP 1 MaSanh  AS NewMaSanh
        FROM [SE104].[dbo].[SANH]
        ORDER BY MaSanh DESC;
    """
    cursor.execute(sql_query_name)
    file_name = cursor.fetchone()[0]
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'SanhCuoi', 'img',file_name)
    img.save(file_path)
    conn.commit()
    
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/XoaSanh', methods = ["POST"])
def XoaSanh():
    data = request.get_json()
    MaSanh = int(data.get('MaSanh'))
    file_name = str(MaSanh) + '.jpg'
    file_path = os.path.join('static','SanhCuoi','img',file_name)
    os.remove(file_path)
    sql_query = """
        exec XoaSanh @MaSanh = ?;
    """
    cursor.execute(sql_query, (MaSanh))
    conn.commit()
    
    print('Xoa Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/Suasanh', methods = ["POST"])
def SuaSanh():
    MaSanh = int(request.form.get('MaSanh'))
    TenSanh = str(request.form.get('TenSanh'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    DiaChi = str(request.form.get('DiaChi'))
    img = request.files['image']
    file_name = str(MaSanh) + '.jpg'
    file_path = os.path.join('static','SanhCuoi','img',file_name)
    img.save(file_path)
    sql_query = """
        UPDATE SANH
        SET TenSanh = ?, DonGia = ?, DiaChi = ?
        WHERE MaSanh = ?;
    """
    cursor.execute(sql_query, (TenSanh,DonGia,DiaChi,MaSanh))
    conn.commit()
    
    print('Sua Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))


@tuychinh_bp.route('/ThemDichVu', methods = ["POST"])
def ThemDichVu():
    TenDichVu = str(request.form.get('TenDichVu'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    img = request.files['image']
    sql_query = """
        EXEC ThemDichVu @TenDichVu = ?, @DonGia = ?
    """
    cursor.execute(sql_query, (TenDichVu,DonGia))
    conn.commit()
    sql_query = """
        SELECT TOP 1 MaDichVu  AS MaDichVu
        FROM [SE104].[dbo].[DICHVU]
        ORDER BY MaDichVu DESC;
    """
    cursor.execute(sql_query)
    file_name = cursor.fetchone()[0]
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'DichVu', 'img',file_name)
    img.save(file_path)
    conn.commit()
    
    print('Xoa Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/XoaDichVu', methods = ["POST"])
def XoaDichVu():
    data = request.get_json()
    MaDichVu = int(data.get('MaDichVu'))
    sql_query = """
        EXEC DeleteDichVuWithDependencies @MaDichVu = ?;
    """
    cursor.execute(sql_query, (MaDichVu))
    conn.commit()
    file_name = str(MaDichVu)
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'DichVu', 'img',file_name)
    os.remove(file_path)
    
    return redirect(url_for('tuychinh_bp.tuychinh'))


@tuychinh_bp.route('/SuaDichVu', methods = ["POST"])
def SuaDichVu():
    MaDichVu = int(request.form.get('MaDichVu'))
    TenDichVu = str(request.form.get('TenDichVu'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    img = request.files['image']
    file_name = str(MaDichVu) + '.jpg'
    file_path = os.path.join('static','DichVu','img',file_name)
    img.save(file_path)
    sql_query = """
        UPDATE DICHVU
        SET TenDichVu = ?, DonGia = ?
        WHERE MaDichVu = ?;
    """
    cursor.execute(sql_query, (TenDichVu,DonGia,MaDichVu))
    conn.commit()
    
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/ThemThucDon', methods = ["POST"])
def ThemThucDon():
    TenThucDon = str(request.form.get('TenThucDon'))
    MonKhaiVi = str(request.form.get('MonKhaiVi'))
    MonChinh1 = str(request.form.get('MonChinh1'))
    MonChinh2 = str(request.form.get('MonChinh2'))
    MonChinh3 = str(request.form.get('MonChinh3'))
    MonLau = str(request.form.get('MonLau'))
    MonTrangMieng = str(request.form.get('MonTrangMieng'))
    Bia = str(request.form.get('Bia'))
    NuocNgot = str(request.form.get('NuocNgot'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    img = request.files['image']
    sql_query = """
         EXEC ThemThucDon 
            @MonKhaiVi = ?, 
            @MonChinh1 = ?, 
            @MonChinh2 = ?, 
            @MonChinh3 = ?, 
            @Lau = ?, 
            @TrangMieng = ?, 
            @Bia = ?, 
            @NuocNgot = ?, 
            @GiaThucDon = ?, 
            @TenThucDon = ?
    """
    cursor.execute(sql_query, (MonKhaiVi, MonChinh1, MonChinh2, MonChinh3, MonLau,\
                               MonTrangMieng, Bia, NuocNgot, DonGia, TenThucDon))
    conn.commit()
    sql_query = """
        SELECT TOP 1 MaThucDon  AS MaThucDon
        FROM [SE104].[dbo].[THUCDON]
        ORDER BY MaThucDon DESC;
    """
    cursor.execute(sql_query)
    conn.commit()
    file_name = cursor.fetchone()[0]
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'Menu', 'img',file_name)
    img.save(file_path)
    
    return redirect(url_for('tuychinh_bp.tuychinh'))


@tuychinh_bp.route('/SuaThucDon', methods = ["POST"])
def SuaThucDon():
    MaThucDon = str(request.form.get('MaThucDon'))
    TenThucDon = str(request.form.get('TenThucDon'))
    MonKhaiVi = str(request.form.get('MonKhaiVi'))
    MonChinh1 = str(request.form.get('MonChinh1'))
    MonChinh2 = str(request.form.get('MonChinh2'))
    MonChinh3 = str(request.form.get('MonChinh3'))
    MonLau = str(request.form.get('MonLau'))
    MonTrangMieng = str(request.form.get('MonTrangMieng'))
    Bia = str(request.form.get('Bia'))
    NuocNgot = str(request.form.get('NuocNgot'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    img = request.files['image']
    sql_query = """
        UPDATE THUCDON 
        SET MonKhaiVi = ?, MonChinh1 = ?, MonChinh2 = ?, MonChinh3 = ?, Lau = ?, TrangMieng = ?, Bia = ?, NuocNgot = ?, GiaThucDon = ?, TenThucDon = ?
        WHERE MaThucDon = ?
     """
    cursor.execute(sql_query, (MonKhaiVi, MonChinh1, MonChinh2, MonChinh3, MonLau,\
                               MonTrangMieng, Bia, NuocNgot, DonGia, TenThucDon, MaThucDon))
    file_name = str(MaThucDon) + ".jpg"
    file_path = os.path.join('static', 'Menu', 'img',file_name)
    img.save(file_path)
    conn.commit()
    
    print('Xoa Sanh')
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/XoaCa', methods = ["POST"])
def XoaCa():
    data = request.get_json()
    MaCa = str(data.get('MaCa'))
    sql_query = """
        EXEC XoaCa @MaCa = ?;
    """
    cursor.execute(sql_query, (MaCa))
    conn.commit()

    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/ThemCa', methods = ["POST"])
def ThemCa():
    ThoiGianBatDau = str(request.form.get('ThoiGianBatDau'))
    ThoiGIanKetThuc = str(request.form.get('ThoiGianKetThuc'))
    sql_query = """
        EXEC sp_InsertCA @ThoiGianBatDau = ?, @ThoiGianKetThuc = ?
    """
    cursor.execute(sql_query, (ThoiGianBatDau,ThoiGIanKetThuc))
    conn.commit()
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/SuaCa', methods = ["POST"])
def SuaCa():
    MaCa = str(request.form.get('MaCa'))
    ThoiGianBatDau = str(request.form.get('ThoiGianBatDau'))
    ThoiGIanKetThuc = str(request.form.get('ThoiGianKetThuc'))
    sql_query = """
       Update CA Set ThoiGianBatDau = ?, ThoiGianKetThuc = ? where MaCa = ?
    """
    cursor.execute(sql_query, (ThoiGianBatDau,ThoiGIanKetThuc,MaCa))
    conn.commit()
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/role', methods = ['POST'])
def role():
    data = request.get_json()
    MaHoaDon = int(data.get('MaHoaDon'))
    NgayThanhToan = str(data.get('NgayThanhToan'))
    TongTienThanhToan = int(data.get('TongTienThanhToan'))
    ngay_nhan = datetime.strptime(TongTienThanhToan, '%Y-%m-%d')
    songay = int((datetime.now() - ngay_nhan).days)
    TienPhat = int(TongTienThanhToan*0.1*songay)
    TinhTrangThanhToan = "Đã Áp Dụng Phạt"
    sql_query = """
        UPDATE HOADON
        SET TienPhat = ? , TinhTrangThanhToan = ?
        WHERE MaHoaDon = ?
    """
    
    cursor.execute(sql_query,(TienPhat, TinhTrangThanhToan, MaHoaDon))
    conn.commit()
    
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/pay', methods = ['POST'])
def pay():
    data = request.get_json()
    MaHoaDon = int(data.get('MaHoaDon'))
    TinhTrangThanhToan = 'Đã Thanh Toán'
    sql_query = """
        UPDATE HOADON
        SET TinhTrangThanhToan = ?
        WHERE MaHoaDon = ?
    """
    
    cursor.execute(sql_query,(TinhTrangThanhToan, MaHoaDon))
    conn.commit()
    
    return redirect(url_for('tuychinh_bp.tuychinh'))