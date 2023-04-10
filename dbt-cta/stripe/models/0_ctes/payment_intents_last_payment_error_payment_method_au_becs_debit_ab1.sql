{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_base') }}
select
    _airbyte_payment_method_hashid,
    {{ json_extract_scalar('au_becs_debit', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('au_becs_debit', ['bsb_number'], ['bsb_number']) }} as bsb_number,
    {{ json_extract_scalar('au_becs_debit', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_base') }} as table_alias
-- au_becs_debit at payment_intents_base/last_payment_error/payment_method/au_becs_debit
where 1 = 1
and au_becs_debit is not null
{{ incremental_clause('_airbyte_emitted_at') }}

