{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_line_items_applied_discounts') }}
select
    _airbyte_applied_discounts_hashid,
    {{ json_extract_scalar('applied_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('applied_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_applied_discounts_base') }}
-- applied_money at orders/line_items/applied_discounts/applied_money
where
    1 = 1
    and applied_money is not null
