import pyodbc

## connect database mẫu cho ae 
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                              'SERVER=DESKTOP-VB58721;'
                              'DATABASE=test;'
                              'Trusted_Connection=yes;')
cursor = conn.cursor()

    # Câu lệnh SQL
sql_query = """
            SELECT CASE 
                WHEN EXISTS (
                    SELECT 1 FROM NGUOIDUNG 
                    WHERE UserID = ? AND PasswordHash = ?
                ) THEN 1 
                ELSE 0 
            END AS Result
        """

    # Thực thi câu lệnh SQL với tham số
cursor.execute(sql_query, ('hoang','H@150523'))
        
    # Lấy kết quả
users = cursor.fetchall()[0]
print(users[0])
print(type(users[0]))