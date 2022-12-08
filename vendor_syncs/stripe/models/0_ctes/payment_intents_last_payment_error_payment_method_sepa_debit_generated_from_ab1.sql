{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_base') }}
select
    _airbyte_sepa_debit_hashid,
    {{ json_extract_scalar('generated_from', ['charge'], ['charge']) }} as charge,
    {{ json_extract_scalar('generated_from', ['setup_attempt'], ['setup_attempt']) }} as setup_attempt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_base') }} as table_alias
-- generated_from at payment_intents_base/last_payment_error/payment_method/sepa_debit/generated_from
where 1 = 1
and generated_from is not null
{{ incremental_clause('_airbyte_emitted_at') }}

