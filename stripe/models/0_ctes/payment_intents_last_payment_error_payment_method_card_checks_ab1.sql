{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('checks', ['cvc_check'], ['cvc_check']) }} as cvc_check,
    {{ json_extract_scalar('checks', ['address_line1_check'], ['address_line1_check']) }} as address_line1_check,
    {{ json_extract_scalar('checks', ['address_postal_code_check'], ['address_postal_code_check']) }} as address_postal_code_check,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card') }} as table_alias
-- checks at payment_intents/last_payment_error/payment_method/card/checks
where 1 = 1
and checks is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

