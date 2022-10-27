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
    {{ json_extract_scalar('sepa_debit', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('sepa_debit', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('sepa_debit', ['bank_code'], ['bank_code']) }} as bank_code,
    {{ json_extract_scalar('sepa_debit', ['branch_code'], ['branch_code']) }} as branch_code,
    {{ json_extract_scalar('sepa_debit', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract('table_alias', 'sepa_debit', ['generated_from'], ['generated_from']) }} as generated_from,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method') }} as table_alias
-- sepa_debit at payment_intents/last_payment_error/payment_method/sepa_debit
where 1 = 1
and sepa_debit is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

