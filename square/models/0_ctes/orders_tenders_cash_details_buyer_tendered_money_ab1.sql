{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_tenders_cash_details') }}
select
    _airbyte_cash_details_hashid,
    {{ json_extract_scalar('buyer_tendered_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('buyer_tendered_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_cash_details_base') }} as table_alias
-- buyer_tendered_money at orders/tenders/cash_details/buyer_tendered_money
where 1 = 1
and buyer_tendered_money is not null

