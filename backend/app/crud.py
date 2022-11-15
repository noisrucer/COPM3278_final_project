from .db import db_exe_file

def get_course_within_hours(token: str, hours: int):
    return db_exe_file(R'backend\sql\subclass_within_time.sql',
                       lambda s: s.replace("__TIME_RANGE__", "'{}:0:0'".format(hours)).replace("__TOKEN__", "'{}'".format(token)))


def get_course_info(course_id: str, subclass_id: str, subclass_info_week_day: str):
    return db_exe_file(R'backend\sql\course_info.sql',
                       lambda s: s.replace("__SUBCLASS_ID__", "'{}'".format(subclass_id)).replace('__COURSE_ID__',
                                                                                                  "'{}'".format(course_id)).replace('__SUBCLASS_INFO_WEEK_DAY__', subclass_info_week_day))