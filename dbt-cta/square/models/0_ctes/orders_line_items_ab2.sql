{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_line_items_ab1') }}
select
    _airbyte_orders_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(quantity as {{ dbt_utils.type_string() }}) as quantity,
    cast(item_type as {{ dbt_utils.type_string() }}) as item_type,
    modifiers,
    cast(total_money as {{ type_json() }}) as total_money,
    applied_taxes,
    cast(variation_name as {{ dbt_utils.type_string() }}) as variation_name,
    cast(total_tax_money as {{ type_json() }}) as total_tax_money,
    cast(base_price_money as {{ type_json() }}) as base_price_money,
    applied_discounts,
    cast(catalog_object_id as {{ dbt_utils.type_string() }}) as catalog_object_id,
    cast(gross_sales_money as {{ type_json() }}) as gross_sales_money,
    cast(total_discount_money as {{ type_json() }}) as total_discount_money,
    cast(variation_total_price_money as {{ type_json() }}) as variation_total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_ab1') }}
-- line_items at orders/line_items
where 1 = 1
