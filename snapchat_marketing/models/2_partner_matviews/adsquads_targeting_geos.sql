{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_geos_hashid'
) }}

SELECT
   _airbyte_geos_hashid
  ,MAX(_airbyte_targeting_hashid) as _airbyte_targeting_hashid
  ,MAX(country_code) as country_code
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'adsquads_targeting_geos_base') }}
GROUP BY _airbyte_geos_hashid