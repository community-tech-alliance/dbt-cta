-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_ads_stats_daily_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('ads_stats_daily_ab3') }}
    )
where rownum = 1
