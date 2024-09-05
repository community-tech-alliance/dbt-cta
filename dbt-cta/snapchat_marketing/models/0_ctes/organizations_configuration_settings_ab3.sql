-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by organization_id order by _airbyte_extracted_at desc) as rownum
        from {{ ref('organizations_configuration_settings_ab2') }}
    )
where rownum = 1
