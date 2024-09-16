-- ensures the base model contains only one row per _cta_hashid

select * from
    (
        select
            *,
            row_number() over (partition by _cta_hashid order by _cta_sync_datetime_utc desc) as rownum
        from {{ ref('lead_tags_cte1') }}
    )
where rownum = 1
