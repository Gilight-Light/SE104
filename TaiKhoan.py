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
    return render_template('TaiKhoan/index.html', user = user, authe = authe, info = info)

@taikhoan_bp.route('/update')
def update():
    return redirect('taikhoan_bp.taikhoan')