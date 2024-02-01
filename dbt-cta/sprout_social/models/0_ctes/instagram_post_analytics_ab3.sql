-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_instagram_post_analytics_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('instagram_post_analytics_ab2') }}
    )
where rownum = 1
