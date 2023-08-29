{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'uid',
        'type',
        'state',
        object_to_string('pickup_details'),
        object_to_string('shipment_details'),
    ]) }} as _airbyte_fulfillments_hashid,
    tmp.*
from {{ ref('orders_fulfillments_ab2') }} as tmp
-- fulfillments at orders/fulfillments
where 1 = 1
