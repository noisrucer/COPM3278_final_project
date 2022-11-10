import json
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.responses import JSONResponse

import mysql.connector
import configparser

# Configs
config = configparser.ConfigParser()
try:
    with open('backend/backend.ini') as f:
        config.read_file(f)
except IOError:
    raise ValueError(
        'Please modify and copy backend.ini to backend/backend.ini')

print("Config:", {section: dict(config[section])
      for section in config.sections()})

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
db_connector = mysql.connector.connect(
    user=config['Database']['user'], password=config['Database']['password'], database=config['Database']['database'])
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


def get_course_within_hours(token: str, hours: int):
    return db_exe_file(R'backend\sql\subclass_within_time.sql',
                       lambda s: s.replace("__TIME_RANGE__", "'{}:0:0'".format(hours)).replace("__TOKEN__", "'{}'".format(token)))


def get_course_info(course_id: str, subclass_id: str, subclass_info_id: int):
    return db_exe_file(R'backend\sql\course_info.sql',
                       lambda s: s.replace("__SUBCLASS_ID__", "'{}'".format(subclass_id)).replace('__COURSE_ID__',
                                                                                                  "'{}'".format(course_id)).replace('__SUBCLASS_INFO_ID__', str(subclass_info_id)))

@app.get("/coming_course/{token}", response_class=JSONResponse)
async def read_root(token: str) -> dict:
    courses = get_course_within_hours(token, 5)[0]
    if len(courses) > 0:
        courses = courses[0]
        course_info = get_course_info(
            courses[1], courses[0], int(courses[2]))[0]
        if len(course_info) > 0:
            course_info = course_info[0]
            print(json.dumps(course_info, sort_keys=True,
                  indent=4, separators=(',', ': '), default=str))
            return {
                "CourseID": course_info[0],
                "CourseName":  course_info[1],
                "CourseDescription":  course_info[2],
                "CourseStartTime": course_info[3],
                "CourseEndTime": course_info[4],
                "CourseLocation": course_info[5],
                "CourseZoomLink": course_info[6]
            }

    return {}


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
