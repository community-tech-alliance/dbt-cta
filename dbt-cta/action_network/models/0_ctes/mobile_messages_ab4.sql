-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by id order by _airbyte_extracted_at desc) as rownum
        from {{ ref('mobile_messages_ab3') }}
    )
where rownum = 1
