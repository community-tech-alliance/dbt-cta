{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders_base') }}
{{ unnest_cte(ref('purchase_orders_base'), 'purchase_orders', 'Line') }}
select
    _airbyte_purchase_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('Line'), ['LineNum'], ['LineNum']) }} as LineNum,
    {{ json_extract('', unnested_column_value('Line'), ['ItemBasedExpenseLineDetail'], ['ItemBasedExpenseLineDetail']) }} as ItemBasedExpenseLineDetail,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Description'], ['Description']) }} as Description,
    {{ json_extract_scalar(unnested_column_value('Line'), ['DetailType'], ['DetailType']) }} as DetailType,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Id'], ['Id']) }} as Id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_base') }} as table_alias
-- Line at purchase_orders/Line
{{ cross_join_unnest('purchase_orders', 'Line') }}
where 1 = 1
and Line is not null

