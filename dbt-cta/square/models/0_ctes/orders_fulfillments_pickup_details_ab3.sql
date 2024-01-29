{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_pickup_details_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_fulfillments_hashid',
        'note',
        'ready_at',
        'pickup_at',
        'placed_at',
        object_to_string('recipient'),
        'expires_at',
        'accepted_at',
        'picked_up_at',
        'schedule_type',
        'auto_complete_duration',
    ]) }} as _airbyte_pickup_details_hashid,
    tmp.*
from {{ ref('orders_fulfillments_pickup_details_ab2') }} as tmp
-- pickup_details at orders/fulfillments/pickup_details
where 1 = 1
