{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments') }}
select
    _airbyte_payments_hashid,
    {{ json_extract_scalar('approved_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('approved_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_base') }}
-- approved_money at payments/approved_money
where
    1 = 1
    and approved_money is not null
{{ incremental_clause('_airbyte_emitted_at') }}

