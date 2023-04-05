{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_payment_method_options_base') }}
select
    _airbyte_payment_method_options_hashid,
    {{ json_extract_scalar('boleto', ['expires_after_days'], ['expires_after_days']) }} as expires_after_days,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_base') }} as table_alias
-- boleto at checkout_sessions_base/payment_method_options/boleto
where 1 = 1
and boleto is not null
{{ incremental_clause('_airbyte_emitted_at') }}

