{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_tenders_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_orders_hashid',
        'id',
        'note',
        'type',
        'created_at',
        'payment_id',
        'location_id',
        object_to_string('amount_money'),
        object_to_string('card_details'),
        object_to_string('cash_details'),
        'transaction_id',
    ]) }} as _airbyte_tenders_hashid,
    tmp.*
from {{ ref('orders_tenders_ab2') }} as tmp
-- tenders at orders/tenders
where 1 = 1
