from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
import random
from decimal import Decimal
import os
tuychinh_bp = Blueprint('tuychinh_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@tuychinh_bp.route('/')
def tuychinh():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
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
    # Thực thi câu lệnh SQL với tham số
    # Khách Hàng
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    khachhang = [{'HoTen': str(row[0]), 'TenDangNhap': str(row[1]),\
              'SoDienThoai': str(row[2]), 'MaHoaDon': str(row[3]),'TongTienThanhToan': str(row[4]),\
                'NgayThanhToan': str(row[5]),'TinhTrangThanhToan': str(row[6]), 'MaTiecCuoi': str(row[7])} \
             for row in data_from_db]
    
    # Sảnh
    cursor.execute(sql_query_sanh)
    data_from_db_sanh = cursor.fetchall()
    sanh = [{'MaSanh': str(row[0]), 'TenSanh': str(row[1]),\
              'DonGia': str(row[2]), 'DiaChi': str(row[3]), 'SoBan': str(random.choice(list(range(35,70,5))))} \
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
    # Đóng kết nối
    cursor.close()
    conn.close()
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber']
    }
    
    return render_template('TuyChinh/index.html',khachhang = khachhang, user = session['userid'], info = info, sanh = sanh, dichvu = dichvu, thucdon = thucdon) 

@tuychinh_bp.route('/managesanh', methods = ["POST"])
def Themsanh():
    TenSanh = str(request.form.get('TenSanh'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    DiaChi = str(request.form.get('DiaChi'))
    img = request.files['image']
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        EXEC InsertSanh @TenSanh = ?, @DonGia = ?, @DiaChi = ?;
    """
    cursor.execute(sql_query, (TenSanh,DonGia,DiaChi))
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
    cursor.close()
    conn.close()
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/XoaSanh', methods = ["POST"])
def Xoasanh():
    MaSanh = int(request.form.get('MaSanh'))
    file_name = str(MaSanh) + '.jpg'
    file_path = os.path.join('static','SanhCuoi','img',file_name)
    os.remove(file_path)
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        exec XoaSanh @MaSanh = ?
;
    """
    cursor.execute(sql_query, (MaSanh))
    conn.commit()
    cursor.close()
    conn.close()
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
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        UPDATE SANH
        SET TenSanh = ?, DonGia = ?, DiaChi = ?
        WHERE MaSanh = ?;
    """
    cursor.execute(sql_query, (TenSanh,DonGia,DiaChi,MaSanh))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('tuychinh_bp.tuychinh'))


@tuychinh_bp.route('/ThemDichVu', methods = ["POST"])
def ThemDichVu():
    TenDichVu = str(request.form.get('TenDichVu'))
    DonGia = Decimal(str("{:.2f}".format(float(request.form.get('DonGia')))))
    img = request.files['image']
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
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
    cursor.close()
    conn.close()
    return redirect(url_for('tuychinh_bp.tuychinh'))

@tuychinh_bp.route('/XoaDichVu', methods = ["POST"])
def XoaDichVu():
    MaDichVu = request.form.get('MaDichVu')
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        EXEC DeleteDichVuWithDependencies @MaDichVu = ?;
    """
    cursor.execute(sql_query, (MaDichVu))
    file_name = str(MaDichVu)
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'DichVu', 'img',file_name)
    os.remove(file_path)
    conn.commit()
    cursor.close()
    conn.close()
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
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        UPDATE DICHVU
        SET TenDichVu = ?, DonGia = ?
        WHERE MaDichVu = ?;
    """
    cursor.execute(sql_query, (TenDichVu,DonGia,MaDichVu))
    conn.commit()
    cursor.close()
    conn.close()
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
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
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
    file_name = cursor.fetchone()[0]
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'Menu', 'img',file_name)
    img.save(file_path)
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('tuychinh_bp.tuychinh'))


@tuychinh_bp.route('/XoaThucDon', methods = ["POST"])
def XoaThucDon():
    MaThucDon = request.form.get('MaThucDon')
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        EXEC XoaThucDon @MaThucDon = ?;
    """
    cursor.execute(sql_query, (MaThucDon))
    file_name = str(MaThucDon)
    file_name = str(file_name) + ".jpg"
    file_path = os.path.join('static', 'Menu', 'img',file_name)
    os.remove(file_path)
    conn.commit()
    cursor.close()
    conn.close()
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
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
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
    cursor.close()
    conn.close()
    return redirect(url_for('tuychinh_bp.tuychinh'))
