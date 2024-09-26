-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _daily_campaign_dials_hashid order by time_dialed_est desc) as rownum
        from {{ ref('daily_campaign_dials_cte1') }}
    )
where rownum = 1
