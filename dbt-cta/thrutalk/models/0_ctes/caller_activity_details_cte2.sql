-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _caller_activity_details_hashid order by loaded_at desc) as rownum
        from {{ ref('caller_activity_details_cte1') }}
    )
where rownum = 1