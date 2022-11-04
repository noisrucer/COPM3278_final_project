-- Second since week start --
DROP FUNCTION IF EXISTS GetTimeSinceWeek;

-- DELIMITER $$ --
CREATE FUNCTION GetTimeSinceWeek (ctime TIMESTAMP) RETURNS INT DETERMINISTIC BEGIN DECLARE WeekDiff INT;

SET
    WeekDiff = UNIX_TIMESTAMP(ctime) - UNIX_TIMESTAMP(
        STR_TO_DATE(CONCAT(YEARWEEK(ctime), ' Monday'), '%X%V %W')
    );

RETURN WeekDiff;

END;

-- $$ --
-- DELIMITER ; --
SELECT
    class_comming.curr_time,
    class_comming.star_time,
    class_comming.course_name,
    class_comming.star_time - class_comming.curr_time as time_left
from
    (
        (
            SELECT
                GetTimeSinceWeek(now()) as curr_time,
                GetTimeSinceWeek(SC.stime) as star_time,
                concat(SC.course_id, SC.subclass_id) as course_name
            from
                (
                    SELECT
                        *
                    from
                        Subclass
                    where
                        repeat_weekly = 1
                ) SC
            having
                curr_time < star_time
                and curr_time > star_time - __TIME_RANGE__
        )
        UNION
        (
            select
                GetTimeSinceWeek(class_comming_one_time.curr_time) as curr_time,
                GetTimeSinceWeek(class_comming_one_time.star_time) as star_time,
                class_comming_one_time.course_name as course_name
            from
                (
                    SELECT
                        now() as curr_time,
                        SC.stime as star_time,
                        concat(SC.course_id, SC.subclass_id) as course_name
                    from
                        (
                            SELECT
                                *
                            from
                                Subclass
                            where
                                repeat_weekly = 0
                        ) SC
                    having
                        curr_time < star_time
                        and curr_time > date_add(SC.stime, interval - __TIME_RANGE__ second)
                ) class_comming_one_time
        )
    ) class_comming;