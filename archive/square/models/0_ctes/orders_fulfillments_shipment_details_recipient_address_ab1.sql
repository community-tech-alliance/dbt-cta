{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_fulfillments_shipment_details_recipient') }}
select
    _airbyte_recipient_hashid,
    {{ json_extract_scalar('address', ['locality'], ['locality']) }} as locality,
    {{ json_extract_scalar('address', ['postal_code'], ['postal_code']) }} as postal_code,
    {{ json_extract_scalar('address', ['address_line_1'], ['address_line_1']) }} as address_line_1,
    {{ json_extract_scalar('address', ['administrative_district_level_1'], ['administrative_district_level_1']) }} as administrative_district_level_1,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_fulfillments_shipment_details_recipient_base') }}
-- address at orders/fulfillments/shipment_details/recipient/address
where
    1 = 1
    and address is not null
