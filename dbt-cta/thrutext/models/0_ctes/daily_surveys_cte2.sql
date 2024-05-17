-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _daily_surveys_hashid order by updated_at desc) as rownum
        from {{ ref('daily_surveys_cte1') }}
    )
where rownum = 1
