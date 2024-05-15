from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc

offering_bp = Blueprint('offering_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@offering_bp.route('/')
def offering():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        SELECT * FROM DICHVU
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
    return render_template('Dichvu/index.html', user = session['userid'], posts = posts, orders = session['Order_DichVu'])

@offering_bp.route('/order', methods = ["POST"])
def order():
    data = request.get_json()
    if session['Order_DichVu'] is None:
        session['Order_DichVu'] = []

    session['Order_DichVu'].append({
        'MaDichVu': int(data.get('MaDichVu')),
        'TenDichVu': str(data.get('TenDichVu'))[:250],
        'DonGia': float(data.get('DonGia')),
        'DuongDanAnh': str(data.get('DuongDanAnh'))[:250]
    })
    
    # Xử lý dữ liệu ở đây
    # Ví dụ: lưu vào database, xử lý đặt bàn, vv...
    return redirect(url_for('offering_bp.offering'))
