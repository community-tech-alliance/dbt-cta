{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_risk_evaluation_ab1') }}
select
    _airbyte_payments_hashid,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(risk_level as {{ dbt_utils.type_string() }}) as risk_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_risk_evaluation_ab1') }}
-- risk_evaluation at payments/risk_evaluation
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

