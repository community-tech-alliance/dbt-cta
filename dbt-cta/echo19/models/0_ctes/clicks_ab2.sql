-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by clickId order by dateCreated desc) as rownum
        from {{ ref('clicks_ab1') }}
    )
where rownum = 1
