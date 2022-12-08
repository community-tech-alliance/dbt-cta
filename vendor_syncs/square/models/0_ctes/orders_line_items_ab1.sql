{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'line_items') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['note'], ['note']) }} as note,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['item_type'], ['item_type']) }} as item_type,
    {{ json_extract_array(unnested_column_value('line_items'), ['modifiers'], ['modifiers']) }} as modifiers,
    {{ json_extract('', unnested_column_value('line_items'), ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract_array(unnested_column_value('line_items'), ['applied_taxes'], ['applied_taxes']) }} as applied_taxes,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['variation_name'], ['variation_name']) }} as variation_name,
    {{ json_extract('', unnested_column_value('line_items'), ['total_tax_money'], ['total_tax_money']) }} as total_tax_money,
    {{ json_extract('', unnested_column_value('line_items'), ['base_price_money'], ['base_price_money']) }} as base_price_money,
    {{ json_extract_array(unnested_column_value('line_items'), ['applied_discounts'], ['applied_discounts']) }} as applied_discounts,
    {{ json_extract_scalar(unnested_column_value('line_items'), ['catalog_object_id'], ['catalog_object_id']) }} as catalog_object_id,
    {{ json_extract('', unnested_column_value('line_items'), ['gross_sales_money'], ['gross_sales_money']) }} as gross_sales_money,
    {{ json_extract('', unnested_column_value('line_items'), ['total_discount_money'], ['total_discount_money']) }} as total_discount_money,
    {{ json_extract('', unnested_column_value('line_items'), ['variation_total_price_money'], ['variation_total_price_money']) }} as variation_total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }} as table_alias
-- line_items at orders/line_items
{{ cross_join_unnest('orders', 'line_items') }}
where 1 = 1
and line_items is not null

