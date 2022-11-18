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

# TODO: remove demo
db_cursor.execute('select * from Course')
values = db_cursor.fetchall()
print(values)
print("finish executing...")

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
