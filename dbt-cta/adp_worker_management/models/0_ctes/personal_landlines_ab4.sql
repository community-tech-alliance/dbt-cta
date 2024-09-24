-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_personal_landlines_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('personal_landlines_ab3') }}
    )
where rownum = 1
