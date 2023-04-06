{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscription_items_ab3') }}
select
    id,
    plan,
    start,
    object,
    status,
    created,
    customer,
    discount,
    ended_at,
    livemode,
    metadata,
    quantity,
    trial_end,
    canceled_at,
    tax_percent,
    trial_start,
    subscription,
    current_period_end,
    cancel_at_period_end,
    current_period_start,
    application_fee_percent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_subscription_items_hashid
from {{ ref('subscription_items_ab3') }}
-- subscription_items from {{ source('cta', '_airbyte_raw_subscription_items') }}
where 1 = 1

