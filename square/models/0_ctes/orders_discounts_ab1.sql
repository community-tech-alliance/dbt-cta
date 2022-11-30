{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'discounts') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['scope'], ['scope']) }} as scope,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['percentage'], ['percentage']) }} as percentage,
    {{ json_extract('', unnested_column_value('discounts'), ['applied_money'], ['applied_money']) }} as applied_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- discounts at orders/discounts
{{ cross_join_unnest('orders', 'discounts') }}
where 1 = 1
and discounts is not null

