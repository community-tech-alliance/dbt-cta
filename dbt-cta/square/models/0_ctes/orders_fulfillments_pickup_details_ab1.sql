{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_fulfillments') }}
select
    _airbyte_fulfillments_hashid,
    {{ json_extract_scalar('pickup_details', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('pickup_details', ['ready_at'], ['ready_at']) }} as ready_at,
    {{ json_extract_scalar('pickup_details', ['pickup_at'], ['pickup_at']) }} as pickup_at,
    {{ json_extract_scalar('pickup_details', ['placed_at'], ['placed_at']) }} as placed_at,
    {{ json_extract('table_alias', 'pickup_details', ['recipient'], ['recipient']) }} as recipient,
    {{ json_extract_scalar('pickup_details', ['expires_at'], ['expires_at']) }} as expires_at,
    {{ json_extract_scalar('pickup_details', ['accepted_at'], ['accepted_at']) }} as accepted_at,
    {{ json_extract_scalar('pickup_details', ['picked_up_at'], ['picked_up_at']) }} as picked_up_at,
    {{ json_extract_scalar('pickup_details', ['schedule_type'], ['schedule_type']) }} as schedule_type,
    {{ json_extract_scalar('pickup_details', ['auto_complete_duration'], ['auto_complete_duration']) }} as auto_complete_duration,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_base') }} as table_alias
-- pickup_details at orders/fulfillments/pickup_details
where 1 = 1
and pickup_details is not null

