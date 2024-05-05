from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

home_bp = Blueprint('home_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@home_bp.route('/')
def home():
    return render_template('Trangchu\index.html')