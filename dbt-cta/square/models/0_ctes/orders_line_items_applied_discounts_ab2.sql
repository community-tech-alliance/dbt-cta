{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_line_items_applied_discounts_ab1') }}
select
    _airbyte_line_items_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(discount_uid as {{ dbt_utils.type_string() }}) as discount_uid,
    cast(applied_money as {{ type_json() }}) as applied_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_line_items_applied_discounts_ab1') }}
-- applied_discounts at orders/line_items/applied_discounts
where 1 = 1
