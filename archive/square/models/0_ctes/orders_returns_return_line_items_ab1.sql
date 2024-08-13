{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_returns') }}
{{ unnest_cte(ref('orders_returns'), 'returns', 'return_line_items') }}
select
    _airbyte_returns_hashid,
    {{ json_extract_scalar(unnested_column_value('return_line_items'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('return_line_items'), ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar(unnested_column_value('return_line_items'), ['item_type'], ['item_type']) }} as item_type,
    {{ json_extract('', unnested_column_value('return_line_items'), ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract('', unnested_column_value('return_line_items'), ['total_tax_money'], ['total_tax_money']) }} as total_tax_money,
    {{ json_extract('', unnested_column_value('return_line_items'), ['base_price_money'], ['base_price_money']) }} as base_price_money,
    {{ json_extract('', unnested_column_value('return_line_items'), ['gross_return_money'], ['gross_return_money']) }} as gross_return_money,
    {{ json_extract('', unnested_column_value('return_line_items'), ['total_discount_money'], ['total_discount_money']) }} as total_discount_money,
    {{ json_extract('', unnested_column_value('return_line_items'), ['variation_total_price_money'], ['variation_total_price_money']) }} as variation_total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_returns_base') }}
-- return_line_items at orders/returns/return_line_items
{{ cross_join_unnest('returns', 'return_line_items') }}
where
    1 = 1
    and return_line_items is not null
