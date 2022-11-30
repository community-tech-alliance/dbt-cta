{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_shipment_details_recipient_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_recipient_hashid',
        'locality',
        'postal_code',
        'address_line_1',
        'administrative_district_level_1',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('orders_fulfillments_shipment_details_recipient_address_ab2') }} tmp
-- address at orders/fulfillments/shipment_details/recipient/address
where 1 = 1

