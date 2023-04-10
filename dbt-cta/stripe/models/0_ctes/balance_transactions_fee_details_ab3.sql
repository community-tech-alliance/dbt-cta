{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('balance_transactions_fee_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_balance_transactions_hashid',
        'type',
        'amount',
        'currency',
        'application',
        'description',
    ]) }} as _airbyte_fee_details_hashid,
    tmp.*
from {{ ref('balance_transactions_fee_details_ab2') }} tmp
-- fee_details at balance_transactions/fee_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

