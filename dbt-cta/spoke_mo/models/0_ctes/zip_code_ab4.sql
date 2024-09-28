{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'zip'
) }}

-- SQL model to get latest `zip_code` values
-- depends_on: {{ ref('zip_code_ab3') }}

select * from
    (
        select
            *,
            row_number() over (partition by zip order by _airbyte_extracted_at desc) as rownum
        from {{ ref('zip_code_ab3') }}
    )
where rownum = 1
