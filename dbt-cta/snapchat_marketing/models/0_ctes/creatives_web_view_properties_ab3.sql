-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by creative_id order by _airbyte_extracted_at desc) as rownum
        from {{ ref('creatives_web_view_properties_ab2') }}
    )
where rownum = 1
