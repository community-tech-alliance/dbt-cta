{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_total_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_total_money_hashid,
    tmp.*
from {{ ref('payments_total_money_ab2') }} tmp
-- total_money at payments/total_money
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

