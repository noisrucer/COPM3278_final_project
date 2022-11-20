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
    
def get_course_event(course_id: str, subclass_id: str):
    return db_exe_file('backend/sql/get_subclass_event.sql',
                       lambda s: s.replace("__COURSE_ID__", "'{}'".format(course_id)).replace("__SUBCLASS_ID__", "'{}'".format(subclass_id)))
    
def get_student_email_by_student_id(student_id: str):
    return db_exe_file('backend/sql/get_student_email_by_student_id.sql',
                       lambda s: s.replace("__STUDENT_ID__", "'{}'".format(student_id)))
    
def create_email_activity(student_id, course_id, subclass_id, action_date):
    return db_exe_file('backend/sql/create_email_activity.sql',
                       lambda s: s.replace(
                           "__STUDENT_ID__", "'{}'".format(student_id)
                           ).replace(
                               "__COURSE_ID__", "'{}'".format(course_id)
                           ).replace(
                               "__SUBCLASS_ID__", "'{}'".format(subclass_id)
                           ).replace(
                               "__ACTION_DATE__", "'{}'".format(action_date)
                           )
                       )
                       

def create_redirection_activity(student_id, subclass_event_id, type, action_date):
    return db_exe_file('backend/sql/create_redirection_activity.sql',
                       lambda s: s.replace(
                           "__STUDENT_ID__", "'{}'".format(student_id)
                           ).replace(
                               "__SUBCLASS_EVENT_ID__", "{}".format(subclass_event_id if subclass_event_id else 'NULL')
                           ).replace(
                               "__TYPE__", "'{}'".format(type)
                           ).replace(
                               "__ACTION_DATE__", "'{}'".format(action_date)
                           )
                       )
    

def logout(login_token, logout_time):
    return db_exe_file('backend/sql/logout.sql',
                       lambda s: s.replace(
                            "__LOGOUT_TIME__", "'{}'".format(logout_time)
                           ).replace(
                           "__LOGIN_TOKEN__", "'{}'".format(login_token)
                           )
                       )

def get_shortest_path_and_times(from_location: str, to_location: str, time_section: int):
    return db_exe_file('backend/sql/path_search.sql',
                       lambda s: s.replace("__FROM_LOCATION__", "'{}'".format(from_location))
                       .replace("__TO_LOCATION__", "'{}'".format(to_location))
                       .replace("__TIME_SECTION__", "{}".format(time_section)))

def get_location_name_by_id(id: int):
    return db_exe_file('backend/sql/location_name_by_id.sql',
                       lambda s: s.replace("__LOCATION_ID__", "'{}'".format(id)))

def get_next_course(login_token: str, current_course_id: str, current_subclass_id: str, week_day: str):
    return db_exe_file('backend/sql/get_course_after_in_day.sql',
                       lambda s: s.replace("__COURSE_ID__", "'{}'".format(current_course_id))
                       .replace("__SUBCLASS_ID__", "'{}'".format(current_subclass_id))
                       .replace("__WEEK_DAY__", "'{}'".format(week_day))
                       .replace("__TOKEN__", "'{}'".format(login_token)))
