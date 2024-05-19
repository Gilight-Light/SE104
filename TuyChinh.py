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


    # Đóng kết nối
    cursor.close()
    conn.close()
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber']
    }
    
    return render_template('TuyChinh/index.html',khachhang = khachhang, user = session['userid'], info = info, sanh = sanh) 

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
def Xoasanh():
    MaSanh = str(request.form.get('MaSanh'))
    file_path = os.path.join('static')
    