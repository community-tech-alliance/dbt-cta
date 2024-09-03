{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'refunds') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['status'], ['status']) }} as status,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['tender_id'], ['tender_id']) }} as tender_id,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract('', unnested_column_value('refunds'), ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract_scalar(unnested_column_value('refunds'), ['transaction_id'], ['transaction_id']) }} as transaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }}
-- refunds at orders/refunds
{{ cross_join_unnest('orders', 'refunds') }}
where
    1 = 1
    and refunds is not null
