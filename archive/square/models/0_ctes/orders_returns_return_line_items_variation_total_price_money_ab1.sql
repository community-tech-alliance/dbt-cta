{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_returns_return_line_items') }}
select
    _airbyte_return_line_items_hashid,
    {{ json_extract_scalar('variation_total_price_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('variation_total_price_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_returns_return_line_items_base') }}
-- variation_total_price_money at orders/returns/return_line_items/variation_total_price_money
where
    1 = 1
    and variation_total_price_money is not null
