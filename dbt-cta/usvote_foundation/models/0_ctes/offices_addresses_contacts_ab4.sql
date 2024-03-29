{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_contacts_hashid'
) }}

-- SQL model to dedupe on the hashid field calculated in *_ab3
-- (this step is included because the data source seems to include duplicate rows)
-- depends_on: {{ ref('offices_addresses_contacts_ab3') }}

select * from
    (
        select
            *,
            row_number() over (partition by _airbyte_contacts_hashid order by _airbyte_emitted_at desc) as rownum
        from {{ ref('offices_addresses_contacts_ab3') }}
    )
where rownum = 1
