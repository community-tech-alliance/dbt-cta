{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'tenders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['note'], ['note']) }} as note,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['payment_id'], ['payment_id']) }} as payment_id,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract('', unnested_column_value('tenders'), ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract('', unnested_column_value('tenders'), ['card_details'], ['card_details']) }} as card_details,
    {{ json_extract('', unnested_column_value('tenders'), ['cash_details'], ['cash_details']) }} as cash_details,
    {{ json_extract_scalar(unnested_column_value('tenders'), ['transaction_id'], ['transaction_id']) }} as transaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- tenders at orders/tenders
{{ cross_join_unnest('orders', 'tenders') }}
where 1 = 1
and tenders is not null

