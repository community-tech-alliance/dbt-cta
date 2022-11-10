{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bank_accounts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'last4',
        'object',
        'status',
        'country',
        'currency',
        'customer',
        object_to_string('metadata'),
        'bank_name',
        'fingerprint',
        'routing_number',
        'account_holder_name',
        'account_holder_type',
    ]) }} as _airbyte_bank_accounts_hashid,
    tmp.*
from {{ ref('bank_accounts_ab2') }} tmp
-- bank_accounts
where 1 = 1

