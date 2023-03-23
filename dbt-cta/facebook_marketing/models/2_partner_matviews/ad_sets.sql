{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ source('cta', 'ad_sets_base') }}

SELECT
    *
FROM {{ source('cta', 'ad_sets_base') }}
