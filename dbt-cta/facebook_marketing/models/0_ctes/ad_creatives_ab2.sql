-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_ad_creatives_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('ad_creatives_ab1') }}
    )
where rownum = 1
