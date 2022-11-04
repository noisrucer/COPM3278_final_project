import mysql.connector

conn = mysql.connector.connect(user='root', host="127.0.0.1", password='Ckdwls1541*', database='comp3278_fp')
cursor = conn.cursor()
cursor.execute('select * from student')
values = cursor.fetchall()
print(values)