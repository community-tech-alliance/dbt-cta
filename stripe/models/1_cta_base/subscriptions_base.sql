{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscriptions_ab3') }}
select
    id,
    plan,
    items,
    start,
    object,
    status,
    billing,
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
    days_until_due,
    current_period_end,
    billing_cycle_anchor,
    cancel_at_period_end,
    current_period_start,
    application_fee_percent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_subscriptions_hashid
from {{ ref('subscriptions_ab3') }}
-- subscriptions from {{ source('cta', '_airbyte_raw_subscriptions') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

