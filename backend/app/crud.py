from .db import db_exe_file

def get_course_within_hours(token: str, hours: int):
    return db_exe_file('backend/sql/subclass_within_time.sql',
                       lambda s: s.replace("__TIME_RANGE__", "'{}:0:0'".format(hours)).replace("__TOKEN__", "'{}'".format(token)))


def get_course_info(course_id: str, subclass_id: str, subclass_info_week_day: str):
    return db_exe_file('backend/sql/course_info.sql',
                       lambda s: s.replace("__SUBCLASS_ID__", "'{}'".format(subclass_id)).replace('__COURSE_ID__',
                                                                                                  "'{}'".format(course_id)).replace('__SUBCLASS_INFO_WEEK_DAY__', "'{}'".format(subclass_info_week_day)))
    
def get_timetable(student_id: str):
    return db_exe_file('backend/sql/get_timetable.sql',
                       lambda s: s.replace("__STUDENT_ID__", "'{}'".format(student_id)))
    

def get_student_id_by_token(token: str):
    return db_exe_file('backend/sql/get_student_id_by_token.sql',
                       lambda s: s.replace("__LOGIN_TOKEN__", "'{}'".format(token)))
    

def get_student_name_by_student_id(student_id: str):
    return db_exe_file('backend/sql/get_student_name_by_student_id.sql',
                       lambda s: s.replace("__STUDENT_ID__", "'{}'".format(student_id)))