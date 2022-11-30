{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_returns_return_line_items_ab1') }}
select
    _airbyte_returns_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(quantity as {{ dbt_utils.type_string() }}) as quantity,
    cast(item_type as {{ dbt_utils.type_string() }}) as item_type,
    cast(total_money as {{ type_json() }}) as total_money,
    cast(total_tax_money as {{ type_json() }}) as total_tax_money,
    cast(base_price_money as {{ type_json() }}) as base_price_money,
    cast(gross_return_money as {{ type_json() }}) as gross_return_money,
    cast(total_discount_money as {{ type_json() }}) as total_discount_money,
    cast(variation_total_price_money as {{ type_json() }}) as variation_total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_returns_return_line_items_ab1') }}
-- return_line_items at orders/returns/return_line_items
where 1 = 1

