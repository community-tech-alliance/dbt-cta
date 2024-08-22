-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by group_id order by _airbyte_extracted_at desc) as rownum
        from {{ ref('customer_groups_ab1') }}
    )
where rownum = 1
