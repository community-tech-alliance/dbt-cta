{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_line_items') }}
{{ unnest_cte(ref('orders_line_items'), 'line_items', 'applied_taxes') }}
select
    _airbyte_line_items_hashid,
    {{ json_extract_scalar(unnested_column_value('applied_taxes'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('applied_taxes'), ['tax_uid'], ['tax_uid']) }} as tax_uid,
    {{ json_extract('', unnested_column_value('applied_taxes'), ['applied_money'], ['applied_money']) }} as applied_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_base') }}
-- applied_taxes at orders/line_items/applied_taxes
{{ cross_join_unnest('line_items', 'applied_taxes') }}
where
    1 = 1
    and applied_taxes is not null
