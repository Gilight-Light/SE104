from flask import Flask, render_template, request, redirect, url_for, session, Blueprint
from datetime import datetime, timedelta
import pyodbc
taikhoan_bp = Blueprint('taikhoan_bp', __name__,
                     template_folder = 'templates', 
                     static_folder = 'static')
@taikhoan_bp.route('/')
def taikhoan():
    user = session['userid']
    if session['userauth']  == 'admin':
        authe = session['userauth']
    else: 
        authe = None
    current_date = datetime.now()
    future_date = current_date + timedelta(days=30)

    # Định dạng ngày theo chuẩn 'YYYY-MM-DDTHH:MM'
    # Định dạng ngày theo chuẩn 'D-M-Y'
    future_date_str = future_date.strftime('%Y-%m-%d')
    info = {
    'email' : session['email'],
    'fullname' : session['fullname'],
    'phonenumber' : session['phonenumber'],
    'ngaythanhtoan': future_date_str
    }
    if session['userauth']  == 'admin':
         return render_template('TaiKhoan/index.html', user = user, authe = authe, info = info)
    flag = session['flag']
    session['flag'] = None
    if(session['Order_SanhCuoi'] is not None and session['Order_ThucDon'] is not None and session['Order_DichVu'] is not None):
        session['TongTien'] = (int(session['Order_SanhCuoi']['DonGia']) + int(session['Order_ThucDon']['DonGia']))*int(session['Order_SanhCuoi']['soBan']) + int(session['Order_DichVu'][0]['DonGia'])
    else:
        session['TongTien'] = 0
    sql_query_check = """
        IF EXISTS (SELECT 1 FROM TIECCUOI WHERE UserID = ?)
            BEGIN
                SELECT NGUOIDUNG.FullName AS UserName,
                    SANH.MaSanh,
                    SANH.TenSanh AS VenueName,
                    CA.ThoiGianBatDau AS StartTime,
                    THUCDON.MaThucDon,
                    THUCDON.TenThucDon,
                    THUCDON.MonKhaiVi,
                    THUCDON.MonChinh1,
                    THUCDON.MonChinh2,
                    THUCDON.MonChinh3,
                    THUCDON.Lau,
                    THUCDON.TrangMieng,
                    THUCDON.Bia,
                    THUCDON.NuocNgot,
                    THUCDON.GiaThucDon,
                    DICHVU.TenDichVu,
                    DICHVU.DonGia,
                    TIECCUOI.SoLuongBan,
                    TIECCUOI.SoLuongBanDuTru,
                    SANH.DonGia as DonGiaSanh,
                    SANH.DiaChi as DiaChiSanh,
                    DICHVU.MaDichVu as MaDichVu
                FROM TIECCUOI
                    JOIN NGUOIDUNG ON TIECCUOI.UserID = NGUOIDUNG.UserID
                    JOIN SANH ON TIECCUOI.MaSanh = SANH.MaSanh
                    JOIN CA ON TIECCUOI.MaCa = CA.MaCa
                    JOIN THUCDON ON TIECCUOI.MaThucDon = THUCDON.MaThucDon
                    JOIN DICHVU ON TIECCUOI.MaDichVu = DICHVU.MaDichVu
                WHERE TIECCUOI.UserID = ?;
            END
        ELSE
            BEGIN
            SELECT 0 as KetQua; -- Trả về 0 nếu UserID không tồn tại trong bảng TIECCUOI
        END
    """

    sql_query_NgayToChuc = """
        SELECT ThoiGianBatDau
        FROM CA
        Where ?
    """
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()
    cursor.execute(sql_query_check,(user,user))
    flag_check = cursor.fetchone()[0]
    conn.commit()
    if flag_check != 0:
        check = int(1)
        cursor.execute(sql_query_check,(user,user))
        data_from_db = cursor.fetchone()
        ordersanh = {
            'DuongDanAnh' : f"static/SanhCuoi/img/{data_from_db[1]}.jpg",
            'TenSanh': data_from_db[2],
            'soBan': data_from_db[17],
            'DonGia': data_from_db[19],
            'DiaChi' :data_from_db[20],
            'NgayToChuc' : data_from_db[3]
        }
        orderthucdon = {
            'DuongDanAnh' : f"static/Menu/img/{data_from_db[4]}.jpg",
            'TenThucDon' : data_from_db[5],
            'Mon1': data_from_db[6],
            'Mon2': data_from_db[7],
            'Mon3': data_from_db[8],
            'Mon4': data_from_db[9],
            'Mon5': data_from_db[10],
            'Mon6': data_from_db[11],
            'Bia': data_from_db[12],
            'NuocNgot': data_from_db[13],
            'DonGia': data_from_db[14]
        }
        orderdichvu = {
            'DuongDanAnh': f"static/DichVu/img/{data_from_db[21]}.jpg",
            'TenDichVu': data_from_db[15],
            'DonGia': data_from_db[16]
        }
        conn.commit()
        tongtien = int(ordersanh['DonGia'])*int(ordersanh['soBan']) + int(orderdichvu['DonGia']) + int(orderthucdon['DonGia'])*int(ordersanh['soBan'])
        conn.close()
        return render_template('TaiKhoan/index.html', user = user, authe = authe, info = info, check = check,\
                               ordersanh = ordersanh, orderthucdon = orderthucdon,\
                                tongtien = tongtien)
    check = None
    cursor.close()
    conn.close()
    return render_template('TaiKhoan/index.html', user = user, authe = authe, info = info,\
                            ordersanh = session['Order_SanhCuoi'], orderthucdon = session['Order_ThucDon'], orderdichvu = session['Order_DichVu'],\
                                tongtien = session['TongTien'],\
                                    flag = flag, flag_ex = session['flag_ex'], check = check)

@taikhoan_bp.route('/add', methods = ['POST'])
def add():
    NgayToChuc = request.form.get('ThoiGian')
    NgayToChuc = str((datetime.fromisoformat(NgayToChuc)).strftime('%Y-%m-%d %H:%M:%S'))
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=SE104;'
                              'Trusted_Connection=yes;')
    cursor = conn.cursor()

    sql_query_MaTiecCuoi = """
            SELECT 
                'TC' + RIGHT('000' + CAST(CAST(SUBSTRING(MAX(MaTiecCuoi), 3, 3) AS INT) + 1 AS VARCHAR), 3) AS NextMaTiecCuoi
                FROM TIECCUOI;
    """

    sql_query_MaCa = """
            select MaCa
            from CA
            where ThoiGianBatDau = ?
    """

    cursor.execute(sql_query_MaTiecCuoi)
    MaTiecCuoi = str(cursor.fetchone()[0])

    MaSanh = session['Order_SanhCuoi']['MaSanh']
    MaDichVu = session['Order_DichVu'][0]['MaDichVu']

    cursor.execute(sql_query_MaCa,(NgayToChuc))
    MaCa = str(cursor.fetchone()[0])

    MaThucDon = session['Order_ThucDon']['MaThucDon']
    TienDatCoc = int(0)
    SoBan = session['Order_SanhCuoi']['soBan']
    SoBanDuTru = int(5)
    UserID = session['userid']
    sql_query_flag = """
        IF EXISTS (
            SELECT 1
            FROM TIECCUOI
            WHERE MaSanh = ?  AND MaCa = ?
        )
            SELECT 1
        ELSE
            SELECT 0
    """
    cursor.execute(sql_query_flag,(MaSanh,MaCa))
    flag = cursor.fetchone()[0]
    if flag == 1:
        session['flag'] = 1
        cursor.close()
        conn.close()
        return redirect(url_for('taikhoan_bp.taikhoan'))
    sql_query = """
        EXEC ThemTiecCuoi @MaTiecCuoi = ?, @MaSanh = ?, @MaCa = ?, @MaThucDon = ?, @TienDatCoc = ?, @MaDichVu = ?, @SoLuongBan = ?, @SoLuongBanDuTru = ?, @UserID = ?
    """
    cursor.execute(sql_query,(MaTiecCuoi,MaSanh,MaCa,MaThucDon,TienDatCoc,MaDichVu,SoBan,SoBanDuTru,UserID))
    conn.commit()
    sql_query_hoadon = """
        EXEC InsertHoaDon @MaTiecCuoi = ?, @NgayThanhToan = ?,@TongTienBan = ?, @TongTienThucDon = ?,  @TongTienHoaDon = ?, @TinhTrangThanhToan = ?, @TienPhat = ?;
    """
    current_date = datetime.now()
    future_date = current_date + timedelta(days=30)
    # Định dạng ngày theo chuẩn 'D-M-Y'
    future_date_str = future_date.strftime('%Y-%m-%d')
    tongtienban = int(session['Order_SanhCuoi']['soBan'])*int(session['Order_SanhCuoi']['DonGia'])
    tongtienthucdon = int(session['Order_SanhCuoi']['soBan'])*int(session['Order_ThucDon']['DonGia'])
    tongtienhoadon = session['TongTien']
    TinhTrangThanhToan = 'Chưa Thanh Toán'
    TienPhat = int(0)
    cursor.execute(sql_query_hoadon,(MaTiecCuoi, future_date_str, tongtienban, tongtienthucdon, tongtienhoadon,TinhTrangThanhToan,TienPhat))
    conn.commit()
    session['flag_ex'] = 1
    cursor.close()
    conn.close()
    return redirect(url_for('taikhoan_bp.taikhoan'))