{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_tenders_cash_details_change_back_money_ab1') }}
select
    _airbyte_cash_details_hashid,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_cash_details_change_back_money_ab1') }}
-- change_back_money at orders/tenders/cash_details/change_back_money
where 1 = 1

