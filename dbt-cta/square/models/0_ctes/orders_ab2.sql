{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    taxes,
    cast(source as {{ type_json() }}) as source,
    refunds,
    returns,
    tenders,
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    cast(closed_at as {{ dbt_utils.type_string() }}) as closed_at,
    discounts,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    line_items,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    cast(net_amounts as {{ type_json() }}) as net_amounts,
    cast(total_money as {{ type_json() }}) as total_money,
    fulfillments,
    cast(return_amounts as {{ type_json() }}) as return_amounts,
    service_charges,
    cast(total_tax_money as {{ type_json() }}) as total_tax_money,
    cast(total_tip_money as {{ type_json() }}) as total_tip_money,
    cast(total_discount_money as {{ type_json() }}) as total_discount_money,
    cast(total_service_charge_money as {{ type_json() }}) as total_service_charge_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_ab1') }}
-- orders
where 1 = 1
