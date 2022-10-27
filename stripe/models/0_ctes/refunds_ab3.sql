{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refunds_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'amount',
        'charge',
        'object',
        'reason',
        'status',
        'created',
        'currency',
        object_to_string('metadata'),
        'payment_intent',
        'receipt_number',
        'transfer_reversal',
        'balance_transaction',
        'source_transfer_reversal',
    ]) }} as _airbyte_refunds_hashid,
    tmp.*
from {{ ref('refunds_ab2') }} tmp
-- refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

