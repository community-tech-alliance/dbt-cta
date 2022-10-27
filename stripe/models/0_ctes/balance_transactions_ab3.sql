{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('balance_transactions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'fee',
        'net',
        'type',
        'amount',
        'object',
        'source',
        'status',
        'created',
        'currency',
        'description',
        array_to_string('fee_details'),
        'available_on',
        'exchange_rate',
        array_to_string('sourced_transfers'),
    ]) }} as _airbyte_balance_transactions_hashid,
    tmp.*
from {{ ref('balance_transactions_ab2') }} tmp
-- balance_transactions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

