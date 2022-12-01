{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_fulfillments_pickup_details_recipient_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pickup_details_hashid',
        'display_name',
        'phone_number',
    ]) }} as _airbyte_recipient_hashid,
    tmp.*
from {{ ref('orders_fulfillments_pickup_details_recipient_ab2') }} tmp
-- recipient at orders/fulfillments/pickup_details/recipient
where 1 = 1

