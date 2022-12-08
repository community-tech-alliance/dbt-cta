{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_fulfillments_shipment_details_ab1') }}
select
    _airbyte_fulfillments_hashid,
    cast(carrier as {{ dbt_utils.type_string() }}) as carrier,
    cast(placed_at as {{ dbt_utils.type_string() }}) as placed_at,
    cast(recipient as {{ type_json() }}) as recipient,
    cast(shipped_at as {{ dbt_utils.type_string() }}) as shipped_at,
    cast(packaged_at as {{ dbt_utils.type_string() }}) as packaged_at,
    cast(in_progress_at as {{ dbt_utils.type_string() }}) as in_progress_at,
    cast(tracking_number as {{ dbt_utils.type_string() }}) as tracking_number,
    cast(expected_shipped_at as {{ dbt_utils.type_string() }}) as expected_shipped_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_shipment_details_ab1') }}
-- shipment_details at orders/fulfillments/shipment_details
where 1 = 1

