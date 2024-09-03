{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('transfers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'date',
        'amount',
        'object',
        'created',
        'currency',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        boolean_to_string('reversed'),
        boolean_to_string('automatic'),
        'recipient',
        object_to_string('reversals'),
        'description',
        'destination',
        'source_type',
        'arrival_date',
        'transfer_group',
        'amount_reversed',
        'source_transaction',
        'balance_transaction',
        'statement_descriptor',
        'statement_description',
        'failure_balance_transaction',
    ]) }} as _airbyte_transfers_hashid,
    tmp.*
from {{ ref('transfers_ab2') }} as tmp
-- transfers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

