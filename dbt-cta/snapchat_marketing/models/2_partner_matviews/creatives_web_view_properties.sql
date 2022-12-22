{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_web_view_properties_hashid'
) }}

SELECT
   _airbyte_web_view_properties_hashid
  ,MAX(url) as url
  ,MAX(utm_source) as utm_source
  ,MAX(utm_medium) as utm_medium
  ,MAX(utm_campaign) as utm_campaign
  ,MAX(utm_term) as utm_term
  ,MAX(utm_content) as utm_content
  ,MAX(block_preload) as block_preload
  ,MAX(ARRAY_TO_STRING(deep_link_urls,',')) as deep_link_urls
  ,MAX(use_immersive_mode) as use_immersive_mode
  ,MAX(allow_snap_javascript_sdk) as allow_snap_javascript_sdk
FROM {{ source('cta', 'creatives_web_view_properties_base') }}
GROUP BY _airbyte_web_view_properties_hashid
