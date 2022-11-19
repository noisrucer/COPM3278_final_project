insert into
    foo
values
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15),
    (16),
    (17),
    (18),
    (19),
    (20);

select
    avg(val) as IQRAVG
from
    (
        SELECT
            val,
            NTILE (4) OVER (
                ORDER BY
                    val
            ) buckets
        FROM
            foo
    ) m
where
    buckets > 1
    and buckets < 4;

select
    IF(
        (
            SELECT
                COUNT(*)
            FROM
                foo
        ) >= 4,
        4,
        0
    );

--IQR avg--
select
    IF(
        (
            SELECT
                COUNT(*)
            FROM
                foo
        ) >= 4,
        (
            select
                avg(val) as IQRAVG
            from
                (
                    SELECT
                        val,
                        NTILE (4) OVER (
                            ORDER BY
                                val
                        ) buckets
                    FROM
                        foo
                ) m
            where
                buckets > 1
                and buckets < 4
        ),
        (
            select
                avg(val) as IQRAVG
            from
                foo
        )
    );

create table LocationMeta(
    location_id INT NOT NULL AUTO_INCREMENT,
    loca VARCHAR(100) NOT NULL,
    PRIMARY KEY(location_id),
    UNIQUE(loca)
);

insert into
    LocationMeta
values
    (NULL, 'MWT2'),
    (NULL, 'CYPP2'),
    (NULL, 'CYCP1'),
    (NULL, 'LE2'),
    (NULL, 'CPD-LG.1');

create table PathTime(
    -- provided_by VARCHAR(100) NOT NULL,
    start_loca VARCHAR(100) NOT NULL,
    end_loca VARCHAR(100) NOT NULL,
    time_section INT NOT NULL,
    time_second INT NOT NULL -- PRIMARY KEY(provided_by),
    -- FOREIGN KEY(provided_by) REFERENCES Student(student_id)
);


create table PathTime(
    -- provided_by VARCHAR(100) NOT NULL,
    start_loca_id INT NOT NULL,
    end_loca_id INT NOT NULL,
    time_section INT NOT NULL,
    time_second INT NOT NULL -- PRIMARY KEY(provided_by),
    -- FOREIGN KEY(provided_by) REFERENCES Student(student_id)
);

insert into
    PathTime
values
    ('3035555626', 1, 3, 1, 300),
    ('3035604075', 1, 3, 1, 330),
    ('3035786603', 1, 3, 1, 300),
    ('3035555626', 1, 3, 2, 100300),
    ('3035604075', 1, 3, 2, 100330),
    ('3035786603', 1, 3, 2, 100300),
    ('3035555626', 3, 4, 1, 300),
    ('3035604075', 3, 1, 1, 0),
    ('3035786603', 1, 4, 1, 300);

-- Average time
with StartingLoca (start_loca, end_loca, time_section) as (
    select
        'CPD-LG.1',
        'CYCP2',
        1
),
IQRPathTime (start_loca, end_loca, time_section time) as (
    select
        start_loca,
        end_loca,
        IF(
            (
                SELECT
                    COUNT(*)
                FROM
                    PathTime NATURAL
                    JOIN StartingLoca
            ) >= 4,
            (
                select
                    avg(time_second) as IQRAVG
                from
                    (
                        SELECT
                            time_second,
                            NTILE (4) OVER (
                                ORDER BY
                                    time_second
                            ) buckets
                        FROM
                            PathTime NATURAL
                            JOIN StartingLoca
                    ) m
                where
                    buckets > 1
                    and buckets < 4
            ),
            (
                select
                    avg(time_second) as IQRAVG
                from
                    PathTime NATURAL
                    JOIN StartingLoca
            )
        )
    FROM
        PathTime NATURAL
        JOIN StartingLoca
    group by
        start_loca,
        end_loca
)
select
    *
from
    IQRPathTime;

-- Get path and time
WITH RECURSIVE PathSearch (time, path) AS (
    SELECT
        0,
        -- Should be (log(count(LocationMeta)) + 1 + 1) * depth
        CAST('CPD-LG.1' AS CHAR(2000))
    UNION
    ALL
    SELECT
        ps.time + 1,
        CONCAT(ps.path, '/', CAST(ps.time + 1 AS CHAR))
    FROM
        PathSearch ps,
        PathTime pt
    WHERE
        ps.time < 20
)
SELECT
    *
FROM
    PathSearch;

-- WITH RECURSIVE bfs_path (path_ids, time, visited) AS
select
    start_loca,
    end_loca,
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
                                start_loca,
                                end_loca,
                                time_section,
                                time_second,
                                NTILE (4) OVER (
                                    PARTITION BY start_loca, end_loca, time_section
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
                        start_loca,
                        end_loca,
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
    start_loca,
    end_loca,
    time_section;

-- Path search
with RECURSIVE StartingLoca (start_loca, end_loca, time_section) as (
    select
        'CPD-LG.1',
        'CPD-LG.2',
        1
),
IQRPathTime (start_loca, end_loca, time_section, time) as (
    select
        start_loca,
        end_loca,
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
                                    start_loca,
                                    end_loca,
                                    time_section,
                                    time_second,
                                    NTILE (4) OVER (
                                        -- PARTITION BY has to be in a single line
                                        PARTITION BY start_loca, end_loca, time_section
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
                            start_loca,
                            end_loca,
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
        start_loca,
        end_loca,
        time_section
),
PathSearch (current_loca, time, path) AS (
    select
        start_loca,
        0,
        CAST(start_loca AS CHAR(2000))
    from
        StartingLoca
    UNION
    ALL
    SELECT
        IQRpt.end_loca,
        ps.time + IQRpt.time,
        CONCAT(ps.path, '/', CAST(IQRpt.end_loca AS CHAR))
    FROM
        PathSearch ps,
        IQRPathTime as IQRpt
        JOIN StartingLoca as sl ON (IQRpt.time_section = sl.time_section)
    WHERE
        ps.time < 2000
        and IQRpt.start_loca = ps.current_loca
        and sl.time_section = (select time_section from StartingLoca)
)
SELECT
    ps.*
FROM
    PathSearch ps,
    StartingLoca sl
Where
    ps.current_loca = sl.end_loca
ORDER BY
    ps.time ASC;

-- Path search (id)
with RECURSIVE StartingLoca (start_loca_id, end_loca_id, time_section) as (
    select
        (select location_id from LocationMeta where loca = 'MWT2'),
        (select location_id from LocationMeta where loca = 'CPD-LG.1'),
        1
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
        CAST(CONCAT('/', start_loca_id, '/') AS CHAR(2000)),
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
        ps.time < 1000
        and ps.depth < 20
        and IQRpt.start_loca_id = ps.current_loca_id
        and not ps.path like CONCAT('%/', CAST(IQRpt.end_loca_id AS CHAR), '/%')
        and sl.time_section = (select time_section from StartingLoca)
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