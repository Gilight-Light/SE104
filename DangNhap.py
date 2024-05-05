from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

login_bp = Blueprint('login_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@login_bp.route('/')
def login():
    return render_template('Dangnhap/signIn.html')