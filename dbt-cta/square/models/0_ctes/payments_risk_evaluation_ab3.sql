{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_risk_evaluation_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'created_at',
        'risk_level',
    ]) }} as _airbyte_risk_evaluation_hashid,
    tmp.*
from {{ ref('payments_risk_evaluation_ab2') }} tmp
-- risk_evaluation at payments/risk_evaluation
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

