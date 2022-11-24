with RECURSIVE StartingLoca (start_loca_id, end_loca_id, time_section) as (
    select
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
        __TIME_SECTION__
),
IQRPathTime (start_loca_id, end_loca_id, time_section, time) as (
    select
        start_loca_id,
        end_loca_id,
        time_section,
        IF(
            COUNT(*) >= 4,
            (
                select
                    IQRAVG
                from
                    (
                        select
                            time_section,
                            avg(m.time_second) as IQRAVG
                        from
                            (
                                SELECT
                                    start_loca_id,
                                    end_loca_id,
                                    time_section,
                                    time_second,
                                    NTILE (4) OVER (
                                        -- PARTITION BY has to be in a single line
                                        PARTITION BY start_loca_id, end_loca_id, time_section
                                        ORDER BY
                                            time_second
                                    ) buckets
                                FROM
                                    PathTime
                            ) m
                        where
                            buckets > 1
                            and buckets < 4
                        group by
                            start_loca_id,
                            end_loca_id,
                            time_section
                    ) mm
                where
                    mm.time_section = pt.time_section
            ),
            avg(time_second)
        ) as IQRAVG
    FROM
        PathTime pt
    group by
        start_loca_id,
        end_loca_id,
        time_section
),
PathSearch (current_loca_id, time, path, depth) AS (
    select
        start_loca_id,
        0,
        -- Should be (log(count(LocationMeta)) + 1 + 1) * Max Depth
        CAST(CONCAT('/', start_loca_id, '/') AS CHAR(65535)),
        0
    from
        StartingLoca
    UNION
    ALL
    SELECT
        IQRpt.end_loca_id,
        ps.time + IQRpt.time,
        CONCAT(ps.path, CAST(IQRpt.end_loca_id AS CHAR), '/'),
        ps.depth + 1
    FROM
        PathSearch ps,
        IQRPathTime as IQRpt
        JOIN StartingLoca as sl ON (IQRpt.time_section = sl.time_section)
    WHERE
        ps.time < 10000000
        and ps.depth < 20
        and IQRpt.start_loca_id = ps.current_loca_id
        and not ps.path like CONCAT('%/', CAST(IQRpt.end_loca_id AS CHAR), '/%')
        and sl.time_section = (
            select
                time_section
            from
                StartingLoca
        )
)
SELECT
    ps.*
FROM
    PathSearch ps,
    StartingLoca sl
Where
    ps.current_loca_id = sl.end_loca_id
ORDER BY
    ps.time ASC;