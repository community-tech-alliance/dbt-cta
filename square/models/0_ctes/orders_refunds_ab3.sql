{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_refunds_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'id',
        'reason',
        'status',
        'tender_id',
        'created_at',
        'location_id',
        object_to_string('amount_money'),
        'transaction_id',
    ]) }} as _airbyte_refunds_hashid,
    tmp.*
from {{ ref('orders_refunds_ab2') }} tmp
-- refunds at orders/refunds
where 1 = 1

