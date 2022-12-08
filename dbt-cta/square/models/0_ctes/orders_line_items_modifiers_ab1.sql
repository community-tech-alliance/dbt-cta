{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_line_items') }}
{{ unnest_cte(ref('orders_line_items'), 'line_items', 'modifiers') }}
select
    _airbyte_line_items_hashid,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['name'], ['name']) }} as name,
    {{ json_extract('', unnested_column_value('modifiers'), ['base_price_money'], ['base_price_money']) }} as base_price_money,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['catalog_object_id'], ['catalog_object_id']) }} as catalog_object_id,
    {{ json_extract('', unnested_column_value('modifiers'), ['total_price_money'], ['total_price_money']) }} as total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_base') }} as table_alias
-- modifiers at orders/line_items/modifiers
{{ cross_join_unnest('line_items', 'modifiers') }}
where 1 = 1
and modifiers is not null

