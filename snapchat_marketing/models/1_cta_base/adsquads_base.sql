{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('adsquads_ab3') }}
select
    id,
    name,
    type,
    status,
    auto_bid,
    end_time,
    placement,
    targeting,
    created_at,
    start_time,
    target_bid,
    updated_at,
    campaign_id,
    pacing_type,
    bid_strategy,
    billing_event,
    child_ad_type,
    creation_state,
    delivery_status,
    optimization_goal,
    daily_budget_micro,
    delivery_constraint,
    forced_view_setting,
    lifetime_budget_micro,
    skadnetwork_properties,
    targeting_reach_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_adsquads_hashid
from {{ ref('adsquads_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

