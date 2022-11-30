{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payments_risk_evaluation_ab3') }}
select
    _airbyte_payments_hashid,
    created_at,
    risk_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_risk_evaluation_hashid
from {{ ref('payments_risk_evaluation_ab3') }}
-- risk_evaluation at payments/risk_evaluation from {{ ref('payments') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

