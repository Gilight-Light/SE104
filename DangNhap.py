from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

login_bp = Blueprint('login_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')

@login_bp.route('/')
def login():
    return render_template('Dangnhap/signIn.html')


@login_bp.route('/authe', methods=["POST"])
def authe():
    username = request.form.get('fullname')
    pwd = request.form.get('password')
    if username == 'hoang':
        return redirect(url_for('login_bp.signup'))  
    else:
        return "Tên đăng nhập hoặc mật khẩu không đúng"

@login_bp.route('/signup')
def signup():
    return render_template('Dangnhap/signUp.html')
