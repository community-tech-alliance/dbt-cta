{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_line_items_plan_ab3') }}
select
    _airbyte_invoice_line_items_hashid,
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
from {{ ref('invoice_line_items_plan_ab3') }}
-- plan at invoice_line_items_base/plan from {{ ref('invoice_line_items_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
