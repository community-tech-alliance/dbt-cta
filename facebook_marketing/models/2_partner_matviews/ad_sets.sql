{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ad_sets_hashid'
) }}

-- depends_on: {{ source('cta', 'ad_sets_base') }}

 SELECT
     _airbyte_ad_sets_hashid
    ,MAX(id) as id
    ,MAX(name) as name
    ,MAX(ARRAY_TO_STRING(adlabels,',')) as adlabels
    ,MAX(bid_info) as bid_info
    ,MAX(end_time) as end_time
    ,MAX(targeting) as targeting
    ,MAX(account_id) as account_id
    ,MAX(start_time) as start_time
    ,MAX(campaign_id) as campaign_id
    ,MAX(created_time) as created_time
    ,MAX(daily_budget) as daily_budget
    ,MAX(updated_time) as updated_time
    ,MAX(lifetime_budget) as lifetime_budget
    ,MAX(promoted_object) as promoted_object
    ,MAX(budget_remaining) as budget_remaining
    ,MAX(effective_status) as effective_status
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
FROM {{ source('cta', 'ad_sets_base') }}
GROUP BY _airbyte_ad_sets_hashid