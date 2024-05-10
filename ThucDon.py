from flask import Flask, render_template, request, redirect, url_for, session, Blueprint

thucdon_bp = Blueprint('thucdon_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@thucdon_bp.route('/')
def login():
    return render_template('Menu/index.html')