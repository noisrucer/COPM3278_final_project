select
    SI.subclass_id,
    SI.course_id,
    SI.subclass_info_id,
    SI.stime
from
    SubclassInfo SI,
    Logging L,
    StudentEnrollsSubclass SEC
where
    DAYNAME(now()) = SI.week_day
    and TIME(stime) > cast(now() as time)
    and TIME(stime) - TIME(__TIME_RANGE__) < cast(now() as time)
    and L.login_token = __TOKEN__
    and L.logout_time is null
    and L.student_id = SEC.student_id
    and SEC.course_id = SI.course_id
    and SEC.subclass_id = SI.subclass_id;