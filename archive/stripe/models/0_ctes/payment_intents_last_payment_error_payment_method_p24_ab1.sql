{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_base') }}
select
    _airbyte_payment_method_hashid,
    {{ json_extract_scalar('p24', ['bank'], ['bank']) }} as bank,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_base') }}
-- p24 at payment_intents_base/last_payment_error/payment_method/p24
where
    1 = 1
    and p24 is not null
{{ incremental_clause('_airbyte_emitted_at') }}

