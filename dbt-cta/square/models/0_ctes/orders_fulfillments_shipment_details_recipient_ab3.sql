{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_shipment_details_recipient_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_shipment_details_hashid',
        object_to_string('address'),
        'display_name',
        'phone_number',
    ]) }} as _airbyte_recipient_hashid,
    tmp.*
from {{ ref('orders_fulfillments_shipment_details_recipient_ab2') }} as tmp
-- recipient at orders/fulfillments/shipment_details/recipient
where 1 = 1
