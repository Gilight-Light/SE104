from flask import Flask
from DangNhap import login_bp
from DichVu import offering_bp
from SanhCuoi import sanhcuoi_bp
from TaiKhoan import taikhoan_bp
from TrangChu import home_bp
from TuyChinh import tuychinh_bp

app = Flask(__name__)

app.register_blueprint(login_bp, url_prefix ='/login')
app.register_blueprint(offering_bp, url_prefix = '/offering')
app.register_blueprint(sanhcuoi_bp, url_prefix = '/sanhcuoi')
app.register_blueprint(taikhoan_bp, url_prefix = '/taikhoan')
app.register_blueprint(home_bp, url_prefix = '/home')
app.register_blueprint(tuychinh_bp, url_prefix = '/tuychinh')


if __name__ == '__main__':
    app.run(debug=True)