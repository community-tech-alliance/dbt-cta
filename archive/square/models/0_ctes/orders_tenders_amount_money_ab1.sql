{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_tenders') }}
select
    _airbyte_tenders_hashid,
    {{ json_extract_scalar('amount_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('amount_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_base') }}
-- amount_money at orders/tenders/amount_money
where
    1 = 1
    and amount_money is not null