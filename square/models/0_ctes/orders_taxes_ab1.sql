{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'taxes') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['scope'], ['scope']) }} as scope,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['percentage'], ['percentage']) }} as percentage,
    {{ json_extract('', unnested_column_value('taxes'), ['applied_money'], ['applied_money']) }} as applied_money,
    {{ json_extract_scalar(unnested_column_value('taxes'), ['catalog_object_id'], ['catalog_object_id']) }} as catalog_object_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }} as table_alias
-- taxes at orders/taxes
{{ cross_join_unnest('orders', 'taxes') }}
where 1 = 1
and taxes is not null

