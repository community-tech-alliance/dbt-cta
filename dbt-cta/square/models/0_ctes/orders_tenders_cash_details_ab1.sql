{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_tenders') }}
select
    _airbyte_tenders_hashid,
    {{ json_extract('table_alias', 'cash_details', ['change_back_money'], ['change_back_money']) }} as change_back_money,
    {{ json_extract('table_alias', 'cash_details', ['buyer_tendered_money'], ['buyer_tendered_money']) }} as buyer_tendered_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_base') }} as table_alias
-- cash_details at orders/tenders/cash_details
where
    1 = 1
    and cash_details is not null
