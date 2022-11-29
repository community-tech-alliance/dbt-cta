{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_campaigns_hashid'
) }}

-- depends_on: {{ source('cta', 'campaigns_base') }}

SELECT
     _airbyte_campaigns_hashid
    ,MAX(id) as id
    ,MAX(name) as name
    ,MAX(ARRAY_TO_STRING(adlabels,',')) as adlabels
    ,MAX(objective) as objective
    ,MAX(spend_cap) as spend_cap
    ,MAX(stop_time) as stop_time
    ,MAX(account_id) as account_id
    ,MAX(start_time) as start_time
    ,MAX(buying_type) as buying_type
    ,MAX(ARRAY_TO_STRING(issues_info,',')) as issues_info
    ,MAX(bid_strategy) as bid_strategy
    ,MAX(created_time) as created_time
    ,MAX(daily_budget) as daily_budget
    ,MAX(updated_time) as updated_time
    ,MAX(lifetime_budget) as lifetime_budget
    ,MAX(budget_remaining) as budget_remaining
    ,MAX(effective_status) as effective_status
    ,MAX(source_campaign_id) as source_campaign_id
    ,MAX(special_ad_category) as special_ad_category
    ,MAX(smart_promotion_type) as smart_promotion_type
    ,MAX(budget_rebalance_flag) as budget_rebalance_flag
    ,MAX(ARRAY_TO_STRING(special_ad_category_country,',')) as special_ad_category_country
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
FROM {{ source('cta', 'campaigns_base') }}
GROUP BY _airbyte_campaigns_hashid