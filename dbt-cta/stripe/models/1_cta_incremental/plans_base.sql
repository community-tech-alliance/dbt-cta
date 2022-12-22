{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_plans_hashid',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('plans_ab3') }}
select
    id,
    name,
    tiers,
    active,
    amount,
    object,
    created,
    product,
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
    _airbyte_plans_hashid
from {{ ref('plans_ab3') }}
-- plans from {{ source('cta', '_airbyte_raw_plans') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

