{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_fulfillments_ab1') }}
select
    _airbyte_orders_hashid,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(pickup_details as {{ type_json() }}) as pickup_details,
    cast(shipment_details as {{ type_json() }}) as shipment_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_ab1') }}
-- fulfillments at orders/fulfillments
where 1 = 1

