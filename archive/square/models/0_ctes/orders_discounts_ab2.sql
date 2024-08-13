{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_discounts_ab1') }}
select
    _airbyte_orders_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(scope as {{ dbt_utils.type_string() }}) as scope,
    cast(percentage as {{ dbt_utils.type_string() }}) as percentage,
    cast(applied_money as {{ type_json() }}) as applied_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_discounts_ab1') }}
-- discounts at orders/discounts
where 1 = 1
