{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_shipment_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_fulfillments_hashid',
        'carrier',
        'placed_at',
        object_to_string('recipient'),
        'shipped_at',
        'packaged_at',
        'in_progress_at',
        'tracking_number',
        'expected_shipped_at',
    ]) }} as _airbyte_shipment_details_hashid,
    tmp.*
from {{ ref('orders_fulfillments_shipment_details_ab2') }} tmp
-- shipment_details at orders/fulfillments/shipment_details
where 1 = 1

