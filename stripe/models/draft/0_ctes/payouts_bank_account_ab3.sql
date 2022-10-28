{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payouts_bank_account_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payouts_hashid',
        'id',
        'name',
        'last4',
        'object',
        'status',
        'country',
        'currency',
        object_to_string('metadata'),
        'bank_name',
        'fingerprint',
        'routing_number',
        'account_holder_name',
        'account_holder_type',
    ]) }} as _airbyte_bank_account_hashid,
    tmp.*
from {{ ref('payouts_bank_account_ab2') }} tmp
-- bank_account at payouts/bank_account
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

