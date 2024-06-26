-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_oban_peers_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('oban_peers_ab1') }}
    )
where rownum = 1
