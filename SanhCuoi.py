from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

sanhcuoi_bp = Blueprint('sanhcuoi_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@sanhcuoi_bp.route('/')
def login():
    return render_template('Sanhcuoi/signIn.html')