{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_returns_ab1') }}
select
    _airbyte_orders_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(source_order_id as {{ dbt_utils.type_string() }}) as source_order_id,
    return_line_items,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_returns_ab1') }}
-- returns at orders/returns
where 1 = 1
