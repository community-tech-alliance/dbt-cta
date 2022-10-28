{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('disputes_balance_transactions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_disputes_hashid',
        'id',
    ]) }} as _airbyte_balance_transactions_hashid,
    tmp.*
from {{ ref('disputes_balance_transactions_ab2') }} tmp
-- balance_transactions at disputes/balance_transactions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

