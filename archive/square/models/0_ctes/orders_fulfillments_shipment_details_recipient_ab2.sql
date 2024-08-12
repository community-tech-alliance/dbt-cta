{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_fulfillments_shipment_details_recipient_ab1') }}
select
    _airbyte_shipment_details_hashid,
    cast(address as {{ type_json() }}) as address,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_shipment_details_recipient_ab1') }}
-- recipient at orders/fulfillments/shipment_details/recipient
where 1 = 1
