{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_refunds_ab3') }}
select
    _airbyte_orders_hashid,
    id,
    reason,
    status,
    tender_id,
    created_at,
    location_id,
    amount_money,
    transaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_refunds_hashid
from {{ ref('orders_refunds_ab3') }}
-- refunds at orders/refunds from {{ ref('orders') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

