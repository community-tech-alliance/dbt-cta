{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('campaigns_ab2') }}
select
    id,
    _airbyte_extracted_at,
    _airbyte_raw_id,
    name,
    adlabels,
    objective,
    spend_cap,
    stop_time,
    account_id,
    start_time,
    buying_type,
    issues_info,
    bid_strategy,
    created_time,
    daily_budget,
    updated_time,
    lifetime_budget,
    budget_remaining,
    effective_status,
    source_campaign_id,
    special_ad_category,
    smart_promotion_type,
    budget_rebalance_flag,
    special_ad_category_country
from {{ ref('campaigns_ab2') }}
