{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchase_orders_ShipAddr_ab1') }}
select
    _airbyte_purchase_orders_hashid,
    cast(Long as {{ dbt_utils.type_string() }}) as Long,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(Line1 as {{ dbt_utils.type_string() }}) as Line1,
    cast(Lat as {{ dbt_utils.type_string() }}) as Lat,
    cast(Line2 as {{ dbt_utils.type_string() }}) as Line2,
    cast(Line3 as {{ dbt_utils.type_string() }}) as Line3,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_ShipAddr_ab1') }}
-- ShipAddr at purchase_orders/ShipAddr
where 1 = 1

