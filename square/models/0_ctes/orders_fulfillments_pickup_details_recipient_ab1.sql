{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_fulfillments_pickup_details') }}
select
    _airbyte_pickup_details_hashid,
    {{ json_extract_scalar('recipient', ['display_name'], ['display_name']) }} as display_name,
    {{ json_extract_scalar('recipient', ['phone_number'], ['phone_number']) }} as phone_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_pickup_details_base') }} as table_alias
-- recipient at orders/fulfillments/pickup_details/recipient
where 1 = 1
and recipient is not null

