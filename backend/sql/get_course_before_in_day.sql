with TargetCourseInfo(course_id, subclass_id, week_day) as (
    select
        __COURSE_ID__,
        __SUBCLASS_ID__,
        __WEEK_DAY__
),
TargetCourse as (
    select
        *
    from
        SubclassInfo NATURAL
        JOIN TargetCourseInfo
)
select
    SI.subclass_id,
    SI.course_id,
    SI.week_day
from
    SubclassInfo SI,
    Logging L,
    StudentEnrollsSubclass SEC,
    TargetCourse ts
where
    SI.week_day = ts.week_day
    and TIME(SI.etime) <= TIME(ts.stime)
    and L.login_token = __TOKEN__
    and L.logout_time is null
    and L.student_id = SEC.student_id
    and SEC.course_id = SI.course_id
    and SEC.subclass_id = SI.subclass_id
order by TIME(SI.stime) DESC
limit 1