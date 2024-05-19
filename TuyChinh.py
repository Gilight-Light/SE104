from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
tuychinh_bp = Blueprint('tuychinh_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@tuychinh_bp.route('/')
def login():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        EXEC GetAllInvoiceDetails;
    """
    # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    khachhang = [{'HoTen': str(row[0]), 'TenDangNhap': str(row[1]),\
              'SoDienThoai': str(row[2]), 'MaHoaDon': str(row[3]),'TongTienThanhToan': str(row[4]),\
                'NgayThanhToan': str(row[5]),'TinhTrangThanhToan': str(row[6]), 'MaTiecCuoi': str(row[7])} \
             for row in data_from_db]
    # Đóng kết nối
    cursor.close()
    conn.close()
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber']
    }
    
    return render_template('TuyChinh/index.html',khachhang = khachhang, user = session['userid'], info = info) 