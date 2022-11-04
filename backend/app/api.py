from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse

import mysql.connector
import configparser

# Configs
config = configparser.ConfigParser()
config.read('backend/backend.ini')
print("Config:", {section: dict(config[section]) for section in config.sections()})

# Server setup
app = FastAPI()

origins = [
    "http://localhost:3000",
    "localhost:3000"
]


app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

# Database setup
db_connector = mysql.connector.connect(user=config['Database']['user'], password=config['Database']['password'], database=config['Database']['database'])
db_cursor = db_connector.cursor()

# Utility setup
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

hours = 1
print(db_exe_file(R'backend\sql\subclass_within_time.sql', lambda s : s.replace("__TIME_RANGE__", "60 * 60 * {}".format(hours))))

@app.get("/", tags=["root"], response_class=HTMLResponse)
async def read_root() -> dict:
    return """
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>COMP3278 ICMS</title>
    </head>
    <body>
        <h1>Empty</h1>
    </body>
    </html>
    """
