{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_items_plan_ab3') }}
select
    _airbyte_invoice_items_hashid,
    id,
    name,
    tiers,
    active,
    amount,
    object,
    created,
    product,
    updated,
    currency,
    {{ adapter.quote('interval') }},
    livemode,
    metadata,
    nickname,
    tiers_mode,
    usage_type,
    billing_scheme,
    interval_count,
    aggregate_usage,
    transform_usage,
    trial_period_days,
    statement_descriptor,
    statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_plan_hashid
from {{ ref('invoice_items_plan_ab3') }}
-- plan at invoice_items/plan from {{ ref('invoice_items') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

