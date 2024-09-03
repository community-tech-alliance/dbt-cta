{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_squad_id'
) }}

SELECT
  *
FROM {{ source('cta', 'adsquads_skadnetwork_properties_base') }}
