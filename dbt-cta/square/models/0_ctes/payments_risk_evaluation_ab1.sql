{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments') }}
select
    _airbyte_payments_hashid,
    {{ json_extract_scalar('risk_evaluation', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('risk_evaluation', ['risk_level'], ['risk_level']) }} as risk_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_base') }} as table_alias
-- risk_evaluation at payments/risk_evaluation
where 1 = 1
and risk_evaluation is not null
{{ incremental_clause('_airbyte_emitted_at') }}

