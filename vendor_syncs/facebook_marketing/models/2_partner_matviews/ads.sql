{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_hashid'
) }}

-- depends on: {{ source('cta', 'ads_base') }}

SELECT
    _airbyte_ads_hashid
   ,MAX(creative_id) as creative_id
   ,MAX(id) as id
   ,MAX(name) as name
   ,MAX(status) as status
   ,MAX(ARRAY_TO_STRING(adlabels,',')) as adlabels
   ,MAX(adset_id) as adset_id
   ,MAX(bid_info) as bid_info
   ,MAX(bid_type) as bid_type
   ,MAX(creative) as creative
   ,MAX(targeting) as targeting
   ,MAX(account_id) as account_id
   ,MAX(bid_amount) as bid_amount
   ,MAX(campaign_id) as campaign_id
   ,MAX(created_time) as created_time
   ,MAX(source_ad_id) as source_ad_id
   ,MAX(updated_time) as updated_time
   ,MAX(ARRAY_TO_STRING(tracking_specs,',')) as tracking_specs
   ,MAX(ARRAY_TO_STRING(recommendations,',')) as recommendations
   ,MAX(ARRAY_TO_STRING(conversion_specs,',')) as conversion_specs
   ,MAX(effective_status) as effective_status
   ,MAX(last_updated_by_app_id) as last_updated_by_app_id
   ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
FROM {{ source('cta', 'ads_base') }}
GROUP BY _airbyte_ads_hashid