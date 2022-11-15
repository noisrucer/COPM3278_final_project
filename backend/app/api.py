import json
# from backend.email.email_api import EmailSender
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.responses import JSONResponse

import mysql.connector
import configparser
from .db import db_cursor, db_select, db_exe_file
from .crud import get_course_within_hours, get_course_info

from .routers import auth, user

# from backend.email.email_api import email_sender

# Configs
# config = configparser.ConfigParser()
# try:
#     with open('backend/backend.ini') as f:
#         config.read_file(f)
# except IOError:
#     raise ValueError(
#         'Please modify and copy backend.ini to backend/backend.ini')

# print("Config:", {section: dict(config[section])
#       for section in config.sections()})

# Server setup
app = FastAPI()

app.include_router(auth.router)
app.include_router(user.router)

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

# # Database setup
# db_connector = mysql.connector.connect(
#     user=config['Database']['user'], password=config['Database']['password'], database=config['Database']['database'])
# db_cursor = db_connector.cursor()

# Utility setup
# def db_select(query: str):
#     db_cursor.execute(query)
#     return db_cursor.fetchall()


# def db_exe_file(path: str, modifier):
#     result = []
#     with open(path, 'r') as f:
#         results = db_cursor.execute(modifier(f.read()), multi=True)
#         for cur in results:
#             if cur.with_rows:
#                 result.append(cur.fetchall())

#     return result


# def get_course_within_hours(token: str, hours: int):
#     return db_exe_file(R'backend\sql\subclass_within_time.sql',
#                        lambda s: s.replace("__TIME_RANGE__", "'{}:0:0'".format(hours)).replace("__TOKEN__", "'{}'".format(token)))


# def get_course_info(course_id: str, subclass_id: str, subclass_info_id: int):
#     return db_exe_file(R'backend\sql\course_info.sql',
#                        lambda s: s.replace("__SUBCLASS_ID__", "'{}'".format(subclass_id)).replace('__COURSE_ID__',
#                                                                                                   "'{}'".format(course_id)).replace('__SUBCLASS_INFO_ID__', str(subclass_info_id)))


# def get_coming_course_info(token, hours: int):
#     courses = get_course_within_hours(token, hours)[0]
#     if len(courses) > 0:
#         courses = courses[0]
#         course_info = get_course_info(
#             courses[1], courses[0], courses[2])[0]
#         if len(course_info) > 0:
#             course_info = course_info[0]
#             print(json.dumps(course_info, sort_keys=True,
#                   indent=4, separators=(',', ': '), default=str))
#             return {
#                 "CourseID": course_info[0],
#                 "CourseName":  course_info[1],
#                 "CourseDescription":  course_info[2],
#                 "TeacherMessage": course_info[3],
#                 "CourseStartTime": course_info[4],
#                 "CourseEndTime": course_info[5],
#                 "CourseLocation": course_info[6],
#                 "CourseZoomLink": course_info[7]
#             }

#     return {}


# @app.get("/coming_course/{token}", response_class=JSONResponse)
# async def coming_course(token: str) -> dict:
#     return get_coming_course_info(token, 23)


# @app.post("/send_course_info")
# async def send_course_info(token: str) -> dict:
#     info = get_coming_course_info(token, 23)
#     print(info)
#     if len(info) > 0:

#         with open("backend/email/email-content.html") as f:

#             email_content = f.read().replace('\n', '')

#             arr = [info["CourseID"], info["CourseLocation"],
#                 info["TeacherMessage"], info["CourseZoomLink"]]
#             email_content = email_content.replace(
#                 '__COURSE_INFO__', '<tr>' + ''.join(['<td>' + _ + '</td>' for _ in arr]) + '</tr>')

#             email_content = email_content.replace('__COURSE_MATERIALS__', "")

#             email_sender.send_email("loyusum246807952@gmail.com", email_content)


@app.get("/", tags=["root"], response_class=HTMLResponse)
async def read_root():
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
