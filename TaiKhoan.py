from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

taikhoan_bp = Blueprint('taikhoan_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@taikhoan_bp.route('/')
def taikhoan():
    return render_template('TaiKhoan\index.html')