from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

offering_bp = Blueprint('offering_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@offering_bp.route('/')
def offering():
    return render_template('Dichvu/index.html', user = session['userid'])