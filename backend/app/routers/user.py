import base64
import io
from fastapi import APIRouter
from fastapi.responses import JSONResponse
import json
from .. import crud
from collections import OrderedDict
from pydantic import BaseModel
from datetime import datetime
from typing import Union
from ..db import db_cursor, db_connector
import cv2
from PIL import Image

from backend.email.email_api import email_sender

router = APIRouter(
    prefix="/user",
    tags=["user"]
)

def get_coming_course_info(token, hours: int = 1):
    courses = crud.get_course_within_hours(token, hours)[0]
    if len(courses) > 0:
        courses = courses[0]
        course_info = crud.get_course_info(
            courses[1], courses[0], courses[2])[0]
        if len(course_info) > 0:
            course_info = course_info[0]
            print(json.dumps(course_info, sort_keys=True,
                  indent=4, separators=(',', ': '), default=str))
            return {
                "CourseID": course_info[0],
                "CourseName":  course_info[1],
                "CourseDescription":  course_info[2],
                "TeacherMessage": course_info[3],
                "CourseStartTime": course_info[4],
                "CourseEndTime": course_info[5],
                "CourseLocation": course_info[6],
                "CourseZoomLink": course_info[7]
            }

    return {}


def get_courses_by_day(timetable_courses, day: str):
    return [
        {
            'course_id': c[0],
            'subclass_id': c[1],
            'course_name': c[2],
            'week_day': c[3],
            'stime': c[4],
            'etime': c[5]
        }
        for c in timetable_courses
        if c[3] == day
    ]

def get_response_timetable_courses(student_id, student_name, timetable_courses):
    return {
    "student_id": student_id,
    "student_name": student_name,
    "timetable": {
        'Monday': get_courses_by_day(timetable_courses, 'Monday'),
        'Tuesday': get_courses_by_day(timetable_courses, 'Tuesday'),
        'Wednesday': get_courses_by_day(timetable_courses, 'Wednesday'),
        'Thursday': get_courses_by_day(timetable_courses, 'Thursday'),
        'Friday': get_courses_by_day(timetable_courses, 'Friday'),
        'Saturday': get_courses_by_day(timetable_courses, 'Saturday'),
        'Sunday': get_courses_by_day(timetable_courses, 'Sunday')
    }
}
    

@router.post("/coming_course/{login_token}")
async def get_coming_course_by_token(login_token: str):
    courses = crud.get_course_within_hours(login_token, hours=1)[0]

    # If there's a class within 1 hour
    if len(courses) > 0:
        courses = courses[0]
        week_day = courses[2]
        course_info = crud.get_course_info(
            courses[1], courses[0], courses[2])[0]
        if len(course_info) > 0:
            course_info = course_info[0]
            json.dumps(course_info, sort_keys=True,
                  indent=4, separators=(',', ': '), default=str)
            
            course_id, subclass_id = course_info[0], course_info[1]
            course_events = crud.get_course_event(course_id, subclass_id)[0]
            
            return {
                "CourseEvents": course_events,
                "week_day": week_day,
                "CourseID": course_info[0],
                "SubclassID": course_info[1],
                "CourseName":  course_info[2],
                "CourseDescription":  course_info[3],
                "TeacherMessage": course_info[4],
                "CourseStartTime": course_info[5],
                "CourseEndTime": course_info[6],
                "CourseLocation": course_info[7],
                "CourseZoomLink": course_info[8]
            }

    # If there's no class within 1 hour - return weekly timetable info
    student_id = crud.get_student_id_by_token(login_token)[0][0][0]
    student_name = crud.get_student_name_by_student_id(student_id)[0][0][0]
    
    week_days_sort_key = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    timetable_courses = crud.get_timetable(student_id)[0]
    response_timetable_courses = get_response_timetable_courses(student_id, student_name, timetable_courses)
    response_timetable_courses['timetable'] = OrderedDict(sorted(
        response_timetable_courses['timetable'].items(), key=lambda item: week_days_sort_key.index(item[0])
    ))
    
    return response_timetable_courses


class EmailUserInput(BaseModel):
    student_id: str
    course_id: str
    subclass_id: str
    week_day: str


@router.post('/email_course_info')
async def send_course_info_by_email(email_user_input: EmailUserInput):
    student_id = email_user_input.student_id
    course_id = email_user_input.course_id
    subclass_id = email_user_input.subclass_id
    week_day = email_user_input.week_day
    
    student_email = crud.get_student_email_by_student_id(student_id)[0][0][0]
    
    course_info = crud.get_course_info(
            course_id, subclass_id, week_day)[0][0]
    
    detail = {
                "CourseID": course_info[0],
                "SubclassID": course_info[1],
                "CourseName":  course_info[2],
                "CourseDescription":  course_info[3],
                "TeacherMessage": course_info[4],
                "CourseStartTime": course_info[5],
                "CourseEndTime": course_info[6],
                "CourseLocation": course_info[7],
                "CourseZoomLink": course_info[8],
            }
    
    course_events = crud.get_course_event(course_id, subclass_id)[0]
    print(course_events)
    course_events_html = ""
    for evt in course_events:
        type = evt[4]
        title = evt[5]
        evt_link = evt[6]
        upload_time = evt[7]
        deadline = evt[8] if evt[8] else "TBC"
        
        evt_html = f"""
            <div class="course-event">
                <p><b class="red">{title}</b></p>
                <p><b>Type: </b>{type}</p>
                <p><b>Uploaded Time: </b>{upload_time}</p>
                <p><b>Deadline: </b>{deadline}</p>
                <p><b>Link: </b> <a href="{detail['CourseZoomLink']}">link</a></p>
            </div>
        """
        
        course_events_html += evt_html
    
    with open('backend/email/email-content.html') as f:
        email_content = f.read().replace('\n', '')
        course_full_code = detail["CourseID"] + detail["SubclassID"]
        start_time = detail['CourseStartTime'] + ":00"
        start_hr, start_min = int(start_time.split(':')[0]), int(start_time.split(':')[1])
        current_time = datetime.now().strftime("%H:%M:%S")
        cur_hr, cur_min = int(current_time.split(':')[0]), int(current_time.split(':')[1])
        
        # if next day
        
        # if same day
        time_left = start_hr * 60 + start_min - cur_hr * 60 - cur_min
        
        
        email_content = email_content.replace(
            "__COURSE_FULL_CODE__", course_full_code
        ).replace(
            "__COURSE_LOCATION__", detail['CourseLocation']
        ).replace(
            "__COURSE_START_TIME__", detail['CourseStartTime']
        ).replace(
            "__COURSE_END_TIME__", detail['CourseEndTime']
        ).replace(
            "__COURSE_ZOOM_LINK__", detail['CourseZoomLink']
        ).replace(
            "__TIME_LEFT__", str(time_left)
        ).replace(
            "__TEACHER_MESSAGE__", detail['TeacherMessage']
        ).replace(
            "__COURSE_DESCRIPTION__", detail['CourseDescription']
        ).replace(
            "__COURSE_EVENTS__", course_events_html
        )
        
        # email_content += course_events_html
    # print(email_content)
    email_sender.send_email(
        student_email, email_content, course_full_code
    )
    
    action_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    sql = f"INSERT INTO EmailActivity VALUES (NULL, '{student_id}', '{course_id}', '{subclass_id}', '{action_date}');"
    db_cursor.execute(sql)
    db_connector.commit()
    # crud.create_email_activity(student_id, course_id, subclass_id, action_date)
    
    return {"message": "Message sent to {student_email}"} 
    
class RedirectionActivityInput(BaseModel):
    student_id: str
    subclass_event_id: Union[str, None] = None
    type: str
    
@router.post("/redirection")
async def redirection_activity(redirection_input: RedirectionActivityInput):
    student_id = redirection_input.student_id
    subclass_event_id = redirection_input.subclass_event_id
    type = redirection_input.type
    
    action_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # crud.create_redirection_activity(student_id, subclass_event_id, type, action_date)
    sql = ""
    if not subclass_event_id:
        print("safasdfasaf")
        sql = f"INSERT into redirectionactivity values (NULL, '{student_id}', NULL, '{type}', '{action_date}');"
    else:
        sql = f"INSERT into redirectionactivity values (NULL, '{student_id}', {subclass_event_id}, '{type}', '{action_date}');"
    db_cursor.execute(sql)
    db_connector.commit()
    
    return {"message": "Successfully created RedirectionActivity"}

class GetPathInput(BaseModel):
    from_location: str
    to_location: str
    time_section: int

@router.post("/get_path")
async def get_path(request: GetPathInput):

    print(request)
    result = crud.get_shortest_path_and_times(request.from_location, request.to_location, request.time_section)[0]

    response_json = {'time': None , 'path': [], 'map': None}

    for path_variant in result[::-1]:
        response_json['time'] = path_variant[1]
        response_json['path'] = [crud.get_location_name_by_id(int_id)[0][0][0] for int_id in path_variant[2].split('/')[1:-1]]

        print("time needed:", response_json['time'])
        print("path:", response_json['path'])

    if response_json['time'] is not None:
        with open(R'backend\Campus\Map\LocationCoordinate.json', 'r') as f:
            campus_image = cv2.imread(R'backend\Campus\Map\CampusMap.png')
            location_conservation = json.loads(f.read())
            for i in range(1, len(response_json['path'])):
                cv2.arrowedLine(campus_image, location_conservation[response_json['path'][i - 1]], location_conservation[response_json['path'][i]], (255, 0, 0), 2)
            cv2.imwrite('savedImage.jpg', campus_image)

            buffered = io.BytesIO()
            image = Image.fromarray(campus_image)
            image.save(buffered, format="JPEG")
            response_json["map"] = base64.b64encode(buffered.getvalue())


    return response_json

class GetNextCourseInput(BaseModel):
    login_token: str
    current_course_id: str
    current_subclass_id: str
    week_day: str

@router.post("/get_next_course")
async def get_next_course(request: GetNextCourseInput):
    result = crud.get_next_course(request.login_token, request.current_course_id, request.current_subclass_id, request.week_day)[0]

    if len(result) != 0:
        return {
            "week_day": result[0][2],
            "CourseID": result[0][1],
            "SubclassID": result[0][0],
        }

    return {}