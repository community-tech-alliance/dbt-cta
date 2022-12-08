{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_skadnetwork_properties_hashid'
) }}

SELECT
   _airbyte_skadnetwork_properties_hashid
  ,MAX(status) as status
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'adsquads_skadnetwork_properties_base') }}
GROUP BY _airbyte_skadnetwork_properties_hashid