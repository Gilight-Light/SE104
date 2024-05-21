from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
import pyodbc
login_bp = Blueprint('login_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')

@login_bp.route('/')
def login():
    session['userid'] = None
    session['userauth'] = None
    session['pwd'] = None
    session['fullname'] = None
    session['email'] = None
    session['phonenumber'] = None
    session['Order_SanhCuoi'] = None
    session['Order_ThucDon'] = None
    session['Order_DichVu'] = None
    session['TongTien'] = None
    session['flag'] = None
    session['flag_ex'] = None
    return render_template('Dangnhap/signIn.html')


@login_bp.route('/authelogin', methods=["POST"])
def authelogin():
    userid = request.form.get('fullname')
    pwd = request.form.get('password')
        # Tạo kết nối
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()

    # Câu lệnh SQL
    sql_query = """
        IF EXISTS (
            SELECT 1
                FROM NGUOIDUNG
                WHERE UserID = ? AND PasswordHash = ?
            )
        BEGIN
            SELECT AccountType, FullName, Email, PhoneNumber
            FROM NGUOIDUNG
            WHERE UserID = ? AND PasswordHash = ?
        END
        ELSE
        BEGIN
            SELECT 'NO' AS Result
        END
    """

    # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query, (userid, pwd, userid, pwd))
            

    # Lấy kết quả
    users = cursor.fetchall()[0]


    # Đóng kết nối
    cursor.close()
    conn.close()
        # Trả về kết quả
    if users[0] == 'NO':
        return render_template('Dangnhap/signIn.html', error = "Tên tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại")
    else:
        session['userid'] = userid
        session['userauth'] = users[0]
        session['pwd'] = pwd
        session['fullname'] = users[1]
        session['email'] = users[2]
        session['phonenumber'] = users[3]
        return render_template('TrangChu/index.html', user = session['userid'])

@login_bp.route('/signup')
def signup():
    return render_template('Dangnhap/signUp.html')

@login_bp.route('/authesignup', methods=["POST"])
def authesignup():
    userid = request.form.get('nameaccount')
    pwd = request.form.get('password')
    username = request.form.get('fullname')
    email = request.form.get('email')
    phome = request.form.get('phone')
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()

    # Câu lệnh SQL
    sql_query = """
            SELECT CASE 
                WHEN EXISTS (
                    SELECT 1 FROM NGUOIDUNG 
                    WHERE UserID = ? 
                ) THEN 1 
                ELSE 0 
            END AS Result
        """
     # Thực thi câu lệnh SQL với tham số
    cursor.execute(sql_query, (userid))

    # Lấy kết quả
    result = cursor.fetchone()[0]  # Lấy giá trị đầu tiên từ kết quả
    if result == 0:
        cursor.execute(
            """ INSERT INTO NGUOIDUNG (UserID,FullName,Email,PasswordHash,AccountType,PhoneNumber) VALUES (?, ?, ?, ?, ?, ?)
        """, (userid,username,email,pwd,'customer',phome))
        conn.commit()
        conn.close()
        return render_template('Dangnhap/signUp.html', flag = 'Tạo thành công tài khoản')
    else: 
        conn.close()
        return render_template('Dangnhap/signUp.html', flag = 'Tên đăng nhập đã tồn tại')


