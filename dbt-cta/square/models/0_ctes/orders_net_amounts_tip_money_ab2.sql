{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_net_amounts_tip_money_ab1') }}
select
    _airbyte_net_amounts_hashid,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_net_amounts_tip_money_ab1') }}
-- tip_money at orders/net_amounts/tip_money
where 1 = 1

