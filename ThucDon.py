from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
thucdon_bp = Blueprint('thucdon_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@thucdon_bp.route('/')
def thucdon():
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    sql_query = """
        SELECT * FROM THUCDON
    """
    # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query)
    
    # Lấy kết quả
    data_from_db = cursor.fetchall()
    posts = [{'MaThucDon': str(row[0]), 'TenThucDon': str(row[10]), 'DonGia': int(row[9]), 'DuongDanAnh': f"static/Menu/img/{row[0]}.jpg",\
              'Mon1': str(row[1]),'Mon2': str(row[2]),'Mon3': str(row[3]),'Mon4': str(row[4]),'Mon5': str(row[5]),\
              'Mon6' : str(row[6]), 'Bia': str(row[7]), 'NuocNgot' : str(row[8])} \
             for row in data_from_db]
    # Đóng kết nối
    cursor.close()
    conn.close()
    return render_template('Menu/index.html',user = session['userid'], posts = posts, orders = session['Order_ThucDon'] )

@thucdon_bp.route('/order', methods = ["POST"])
def order():
    data = request.get_json()
    session['Order_ThucDon'] = {
        'MaThucDon' : int(data.get('MaThucDon')),
        'TenThucDon' : str(data.get('TenThucDon'))[:250],
        'DonGia' : float(data.get('DonGia')),
        'DuongDanAnh' : str(data.get('DuongDanAnh'))[:250],
        'Mon1' : str(data.get('Mon1'))[:250],
        'Mon2' : str(data.get('Mon2'))[:250],
        'Mon3' : str(data.get('Mon3'))[:250],
        'Mon4' : str(data.get('Mon4'))[:250],
        'Mon5' : str(data.get('Mon5'))[:250],
        'Mon6' : str(data.get('Mon6'))[:250],
        'Bia' : str(data.get('Bia'))[:250],
        'NuocNgot' : str(data.get('NuocNgot'))[:250]
    }

    return redirect(url_for('thucdon_bp.thucdon'))