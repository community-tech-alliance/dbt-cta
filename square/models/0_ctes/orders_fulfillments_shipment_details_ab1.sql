{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_fulfillments') }}
select
    _airbyte_fulfillments_hashid,
    {{ json_extract_scalar('shipment_details', ['carrier'], ['carrier']) }} as carrier,
    {{ json_extract_scalar('shipment_details', ['placed_at'], ['placed_at']) }} as placed_at,
    {{ json_extract('table_alias', 'shipment_details', ['recipient'], ['recipient']) }} as recipient,
    {{ json_extract_scalar('shipment_details', ['shipped_at'], ['shipped_at']) }} as shipped_at,
    {{ json_extract_scalar('shipment_details', ['packaged_at'], ['packaged_at']) }} as packaged_at,
    {{ json_extract_scalar('shipment_details', ['in_progress_at'], ['in_progress_at']) }} as in_progress_at,
    {{ json_extract_scalar('shipment_details', ['tracking_number'], ['tracking_number']) }} as tracking_number,
    {{ json_extract_scalar('shipment_details', ['expected_shipped_at'], ['expected_shipped_at']) }} as expected_shipped_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments') }} as table_alias
-- shipment_details at orders/fulfillments/shipment_details
where 1 = 1
and shipment_details is not null

