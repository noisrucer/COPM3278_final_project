insert into
    PathTime
values
    (
        __STUDENT_ID__,
        (
            select
                location_id
            from
                LocationMeta
            where
                loca = __FROM_LOCATION__
        ),
        (
            select
                location_id
            from
                LocationMeta
            where
                loca = __TO_LOCATION__
        ),
        __TIME_SECTION__,
        __TIME__
    ) ON DUPLICATE KEY
UPDATE
    time_second = __TIME__;
