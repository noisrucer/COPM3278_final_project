select
    concat(C.course_id, SC.subclass_id),
    C.name,
    C.description,
    SC.teacher_message,
    SCI.stime,
    SCI.etime,
    SCI.class_loca,
    SCI.zoom_link
from
    Course C,
    Subclass SC,
    SubclassInfo SCI
where
    C.course_id = SC.course_id
    and SC.subclass_id = __SUBCLASS_ID__
    and SC.course_id = __COURSE_ID__
    and SCI.course_id = SC.course_id
    and SCI.subclass_id = SC.subclass_id
    and SCI.week_day = __SUBCLASS_INFO_WEEK_DAY__;