{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_price_recurring_ab3') }}
select
    _airbyte_price_hashid,
    {{ adapter.quote('interval') }},
    usage_type,
    interval_count,
    aggregate_usage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recurring_hashid
from {{ ref('checkout_sessions_line_items_price_recurring_ab3') }}
-- recurring at checkout_sessions_line_items/price/recurring from {{ ref('checkout_sessions_line_items_price_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

