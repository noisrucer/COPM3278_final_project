import configparser
import mysql.connector
from .config import config

# Database setup
db_connector = mysql.connector.connect(
    user=config['Database']['user'],
    password=config['Database']['password'],
    database=config['Database']['database'])

db_cursor = db_connector.cursor()

def db_select(query: str):
    db_cursor.execute(query)
    return db_cursor.fetchall()


def db_exe_file(path: str, modifier):
    result = []
    with open(path, 'r') as f:
        results = db_cursor.execute(modifier(f.read()), multi=True)
        for cur in results:
            if cur.with_rows:
                result.append(cur.fetchall())

    return result