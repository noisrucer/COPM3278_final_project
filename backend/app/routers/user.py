from fastapi import APIRouter
from fastapi.responses import JSONResponse
import json
from .. import crud
from collections import OrderedDict

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