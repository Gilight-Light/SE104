from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

taikhoan_bp = Blueprint('taikhoan_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@taikhoan_bp.route('/')
def taikhoan():
    user = session['userid']
    if session['userauth']  == 'admin':
        authe = session['userauth']
    else: 
        authe = None
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber']
    }
    session['TongTien'] = int(session['Order_SanhCuoi']['DonGia']) + int(session['Order_ThucDon']['DonGia']) + int(session['Order_DichVu'][0]['DonGia'])

    return render_template('TaiKhoan/index.html', user = user, authe = authe, info = info,\
                            ordersanh = session['Order_SanhCuoi'], orderthucdon = session['Order_ThucDon'], orderdichvu = session['Order_DichVu'],\
                                tongtien = session['TongTien'])

@taikhoan_bp.route('/update')
def update():
    return redirect('taikhoan_bp.taikhoan')