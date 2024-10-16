-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by ap_ru_data_hashid order by timestamp_last_updated desc) as rownum
        from {{ ref('ap_ru_data_ab1') }}
    )
where rownum = 1
