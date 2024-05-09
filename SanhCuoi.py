from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
sanhcuoi_bp = Blueprint('sanhcuoi_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@sanhcuoi_bp.route('/')
def login():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=test;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        SELECT * FROM SANHTEST
    """
    # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    posts = [{'MaSanh': str(row[0]), 'TenSanh': str(row[1]), 'DonGia': str(row[2]), 'DiaChi': str(row[3]), 'DuongDanAnh': f"static/SanhCuoi/img/{row[0]}.jpg"} \
             for row in data_from_db]
    # Đóng kết nối
    cursor.close()
    conn.close()
    return render_template('Sanhcuoi/listview.html', user = session['userid'], posts = posts)
