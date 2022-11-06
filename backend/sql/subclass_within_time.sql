select
    subclass_id,
    course_id,
    stime
from
    SubclassInfo
where
    DAYNAME(now()) = week_day
    and TIME(stime) > cast(now() as time)
    and TIME(stime) - TIME(__TIME_RANGE__) < cast(now() as time);