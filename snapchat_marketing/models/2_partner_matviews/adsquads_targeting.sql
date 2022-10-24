{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'airbyte_ab_id'
) }}

SELECT
   _airbyte_targeting_hashid
  ,MAX(ARRAY_TO_STRING(geos,',')) as geos
  ,MAX(ARRAY_TO_STRING(demographics,',')) as demographics
  ,MAX(regulated_content) as regulated_content
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'adsquads_targeting_base') }}
GROUP BY _airbyte_targeting_hashid