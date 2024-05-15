from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
sanhcuoi_bp = Blueprint('sanhcuoi_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@sanhcuoi_bp.route('/')
def sanh():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        SELECT * FROM SANH
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
    return render_template('Sanhcuoi/listview.html', user = session['userid'], posts = posts, orders =  session['Order_SanhCuoi'], order = None)

@sanhcuoi_bp.route('/order', methods=['POST'])
def order():
    data = request.get_json()
    session['Order_SanhCuoi'] = {
        'MaSanh' : int(data.get('MaSanh')),
        'TenSanh' : str(data.get('TenSanh'))[:250],
        'DonGia' : float(data.get('DonGia')),
        'DiacChi' : str(data.get('DiaChi'))[:250],
        'DuongDanAnh' : str(data.get('DuongDanAnh'))[:250]
    }
    
    # Xử lý dữ liệu ở đây
    # Ví dụ: lưu vào database, xử lý đặt bàn, vv...
    return redirect(url_for('sanhcuoi_bp.sanh'))

# # @sanhcuoi_bp.route('/order')
# def order():
#     ten_sanh = request.args.get('tenSanh')
#     don_gia = request.args.get('donGia')
#     dia_chi = request.args.get('diaChi')

#     # Xử lý dữ liệu ở đây
#     # Ví dụ: lưu vào database, xử lý đặt bàn, vv...

#     return render_template('test.html', ten_sanh=ten_sanh, don_gia=don_gia, dia_chi=dia_chi)
    

