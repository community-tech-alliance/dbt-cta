{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends on: {{ source('cta', 'ads_base') }}

select
    *
FROM {{ source('cta', 'ads_base') }}
