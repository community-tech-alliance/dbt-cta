{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_geos_hashid'
) }}

SELECT
  *
FROM {{ source('cta', 'adsquads_targeting_geos_base') }}
