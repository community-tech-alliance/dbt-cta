{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_line_items_modifiers_ab1') }}
select
    _airbyte_line_items_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(base_price_money as {{ type_json() }}) as base_price_money,
    cast(catalog_object_id as {{ dbt_utils.type_string() }}) as catalog_object_id,
    cast(total_price_money as {{ type_json() }}) as total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_modifiers_ab1') }}
-- modifiers at orders/line_items/modifiers
where 1 = 1

