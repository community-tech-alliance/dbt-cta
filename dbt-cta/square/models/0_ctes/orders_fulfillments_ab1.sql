{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'fulfillments') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('fulfillments'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('fulfillments'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('fulfillments'), ['state'], ['state']) }} as state,
    {{ json_extract('', unnested_column_value('fulfillments'), ['pickup_details'], ['pickup_details']) }} as pickup_details,
    {{ json_extract('', unnested_column_value('fulfillments'), ['shipment_details'], ['shipment_details']) }} as shipment_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }} as table_alias
-- fulfillments at orders/fulfillments
{{ cross_join_unnest('orders', 'fulfillments') }}
where 1 = 1
and fulfillments is not null

