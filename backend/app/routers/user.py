from fastapi import APIRouter
from fastapi.responses import JSONResponse
import json
from .. import crud

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


@router.get("/coming_course/{login_token}")
async def get_coming_course_by_token(login_token: str):
    courses = crud.get_course_within_hours(login_token, hours=1)[0]
    
    # If there's a class within 1 hour
    if len(courses) > 0:
        print("YOu have course wihtin 1 hour")
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
    return {"time_table_info": "Some timetable info..."}