{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_fulfillments_pickup_details_ab1') }}
select
    _airbyte_fulfillments_hashid,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(ready_at as {{ dbt_utils.type_string() }}) as ready_at,
    cast(pickup_at as {{ dbt_utils.type_string() }}) as pickup_at,
    cast(placed_at as {{ dbt_utils.type_string() }}) as placed_at,
    cast(recipient as {{ type_json() }}) as recipient,
    cast(expires_at as {{ dbt_utils.type_string() }}) as expires_at,
    cast(accepted_at as {{ dbt_utils.type_string() }}) as accepted_at,
    cast(picked_up_at as {{ dbt_utils.type_string() }}) as picked_up_at,
    cast(schedule_type as {{ dbt_utils.type_string() }}) as schedule_type,
    cast(auto_complete_duration as {{ dbt_utils.type_string() }}) as auto_complete_duration,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_pickup_details_ab1') }}
-- pickup_details at orders/fulfillments/pickup_details
where 1 = 1

