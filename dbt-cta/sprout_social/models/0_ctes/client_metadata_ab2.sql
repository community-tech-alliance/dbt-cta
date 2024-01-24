-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * from
    (
        select
            *,
            row_number() over (partition by _airbyte_client_metadata_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('client_metadata_ab1') }}
    )
where rownum = 1
