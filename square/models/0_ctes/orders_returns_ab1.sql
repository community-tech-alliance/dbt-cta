{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'returns') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('returns'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('returns'), ['source_order_id'], ['source_order_id']) }} as source_order_id,
    {{ json_extract_array(unnested_column_value('returns'), ['return_line_items'], ['return_line_items']) }} as return_line_items,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- returns at orders/returns
{{ cross_join_unnest('orders', 'returns') }}
where 1 = 1
and returns is not null

