-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by tag_result_hashid order by dateCreated desc) as rownum
        from {{ ref('tag_result_ab1') }}
    )
where rownum = 1
