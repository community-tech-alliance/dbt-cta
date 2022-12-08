{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_return_amounts_ab1') }}
select
    _airbyte_orders_hashid,
    cast(tax_money as {{ type_json() }}) as tax_money,
    cast(tip_money as {{ type_json() }}) as tip_money,
    cast(total_money as {{ type_json() }}) as total_money,
    cast(discount_money as {{ type_json() }}) as discount_money,
    cast(service_charge_money as {{ type_json() }}) as service_charge_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_return_amounts_ab1') }}
-- return_amounts at orders/return_amounts
where 1 = 1

