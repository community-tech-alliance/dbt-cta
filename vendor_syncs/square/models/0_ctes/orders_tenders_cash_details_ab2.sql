{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_tenders_cash_details_ab1') }}
select
    _airbyte_tenders_hashid,
    cast(change_back_money as {{ type_json() }}) as change_back_money,
    cast(buyer_tendered_money as {{ type_json() }}) as buyer_tendered_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_cash_details_ab1') }}
-- cash_details at orders/tenders/cash_details
where 1 = 1

