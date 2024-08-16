{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customer_balance_transactions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'amount',
        'object',
        'created',
        'invoice',
        'currency',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'credit_note',
        'description',
        'ending_balance',
    ]) }} as _airbyte_customer_balance_transactions_hashid,
    tmp.*
from {{ ref('customer_balance_transactions_ab2') }} as tmp
-- customer_balance_transactions
where 1 = 1
