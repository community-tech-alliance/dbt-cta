{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_fulfillments_shipment_details_ab3') }}
select
    _airbyte_fulfillments_hashid,
    carrier,
    placed_at,
    recipient,
    shipped_at,
    packaged_at,
    in_progress_at,
    tracking_number,
    expected_shipped_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shipment_details_hashid
from {{ ref('orders_fulfillments_shipment_details_ab3') }}
-- shipment_details at orders/fulfillments/shipment_details from {{ ref('orders_fulfillments') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

