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
    class_loca
from
    SubclassInfo NATURAL
    JOIN TargetCourseInfo
limit 1