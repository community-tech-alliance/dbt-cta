-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _opt_outs_hashid order by timestamp desc) as rownum
        from {{ ref('opt_outs_cte1') }}
    )
where rownum = 1
