from pprint import pprint
from collections import OrderedDict

timetable_courses = [[('COMP3230', 'A', 'Principles of Operating Systems', 'Thursday', '10:30', '12:20'), ('COMP3230', 'A', 'Principles of Operating Systems', 'Tuesday', '10:30', '12:20'), ('COMP3258', 'A', 'Functional Programming', 'Friday', '14:30', '15:20'), ('COMP3258', 'A', 'Functional Programming', 'Tuesday', '13:30', '15:20'), ('COMP3278', 'A', 'Intro. to Database Management Systems', 'Monday', '14:30', '15:20'), ('COMP3278', 'A', 'Intro. to Database Management Systems', 'Thursday', '13:30', '15:20'), ('COMP3278', 'A', 'Intro. to Database Management Systems', 'Tuesday', '21:00', '22:20'), ('COMP3330', 'A', 'Interactive mobile application design and programming', 'Monday', '12:30', '14:20'), ('COMP3330', 'A', 'Interactive mobile application design and programming', 'Thursday', '12:30', '13:20')]][0]
print(timetable_courses[0])

def get_courses_by_day(day: str):
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
    
response_timetable_courses = {
    "student_id": None,
    "student_name": None,
    "timetable": {
        'Monday': get_courses_by_day('Monday'),
        'Tuesday': get_courses_by_day('Tuesday'),
        'Wednesday': get_courses_by_day('Wednesday'),
        'Thursday': get_courses_by_day('Thursday'),
        'Friday': get_courses_by_day('Friday'),
        'Saturday': get_courses_by_day('Saturday'),
        'Sunday': get_courses_by_day('Sunday')
    }
}

week_days_sort_key = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
# response_timetable_courses['tiemtable'] = dict(sorted(
#     response_timetable_courses['timetable'].items(), key=lambda item: week_days_sort_key.index(item[0])
#     ))

temp = OrderedDict(sorted(
    response_timetable_courses['timetable'].items(), key=lambda item: week_days_sort_key.index(item[0])
    ))
# pprint(response_timetable_courses)
pprint(temp)
