from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc

offering_bp = Blueprint('offering_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@offering_bp.route('/')
def offering():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=test;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        SELECT * FROM DICHVUTEST
    """
    # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    posts = [{'MaDichVu': str(row[0]), 'TenDichVu': str(row[1]), 'DonGia': str(row[2]), 'DuongDanAnh': f"static/DichVu/img/{row[0]}.jpg"} \
             for row in data_from_db]
    # Đóng kết nối
    cursor.close()
    conn.close()
    return render_template('Dichvu/index.html', user = session['userid'], posts = posts)