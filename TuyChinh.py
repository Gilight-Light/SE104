from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

tuychinh_bp = Blueprint('tuychinh_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@tuychinh_bp.route('/')
def login():
    
    return render_template('TuyChinh/index.html')