{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method') }}
select
    _airbyte_payment_method_hashid,
    {{ json_extract_scalar('bacs_debit', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('bacs_debit', ['sort_code'], ['sort_code']) }} as sort_code,
    {{ json_extract_scalar('bacs_debit', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method') }} as table_alias
-- bacs_debit at payment_intents/last_payment_error/payment_method/bacs_debit
where 1 = 1
and bacs_debit is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

