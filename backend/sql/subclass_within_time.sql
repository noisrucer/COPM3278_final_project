-- Second since week start --

DROP FUNCTION IF EXISTS GetTimeSinceWeek;

-- DELIMITER $$ --
CREATE FUNCTION GetTimeSinceWeek (ctime TIMESTAMP) RETURNS INT DETERMINISTIC BEGIN DECLARE WeekDiff INT;
SET
    WeekDiff = UNIX_TIMESTAMP(ctime) - UNIX_TIMESTAMP(
        STR_TO_DATE(CONCAT(YEARWEEK(ctime), ' Monday'), '%X%V %W')
    );

RETURN WeekDiff;

END; -- $$ --

-- DELIMITER ; --


SELECT
    class_comming.curr_time,
    class_comming.star_time,
    class_comming.course_name,
    class_comming.star_time - class_comming.curr_time as time_left
from
    (
        SELECT
            GetTimeSinceWeek(now()) as curr_time,
            GetTimeSinceWeek(SC.stime) as star_time,
            concat(SC.course_id, SC.subclass_id) as course_name
        from
            Subclass SC
        having
            curr_time < star_time
            and curr_time > star_time - __TIME_RANGE__
    ) class_comming;