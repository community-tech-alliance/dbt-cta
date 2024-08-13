{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_service_charges_ab1') }}
select
    _airbyte_orders_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('taxable') }} as taxable,
    cast(total_money as {{ type_json() }}) as total_money,
    cast(amount_money as {{ type_json() }}) as amount_money,
    cast(applied_money as {{ type_json() }}) as applied_money,
    cast(total_tax_money as {{ type_json() }}) as total_tax_money,
    cast(calculation_phase as {{ dbt_utils.type_string() }}) as calculation_phase,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_service_charges_ab1') }}
-- service_charges at orders/service_charges
where 1 = 1
