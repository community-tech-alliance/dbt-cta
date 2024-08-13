{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
) }}

-- depends_on: {{ ref('ad_sets_ab2') }}
select
    id,
    _airbyte_emitted_at,
    _airbyte_ab_id,
    name,
    adlabels,
    bid_info,
    end_time,
    targeting,
    account_id,
    start_time,
    campaign_id,
    created_time,
    daily_budget,
    updated_time,
    lifetime_budget,
    promoted_object,
    budget_remaining,
    effective_status
from {{ ref('ad_sets_ab2') }}
