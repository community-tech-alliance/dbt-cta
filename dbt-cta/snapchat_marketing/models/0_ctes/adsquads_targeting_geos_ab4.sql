-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_geos_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('adsquads_targeting_geos_ab3') }}
    )
where rownum = 1
