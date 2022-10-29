{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_base') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('wallet', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('wallet', ['apple_pay'], ['apple_pay']) }} as apple_pay,
    {{ json_extract_scalar('wallet', ['google_pay'], ['google_pay']) }} as google_pay,
    {{ json_extract('table_alias', 'wallet', ['masterpass'], ['masterpass']) }} as masterpass,
    {{ json_extract_scalar('wallet', ['samsung_pay'], ['samsung_pay']) }} as samsung_pay,
    {{ json_extract_scalar('wallet', ['dynamic_last4'], ['dynamic_last4']) }} as dynamic_last4,
    {{ json_extract('table_alias', 'wallet', ['visa_checkout'], ['visa_checkout']) }} as visa_checkout,
    {{ json_extract_scalar('wallet', ['amex_express_checkout'], ['amex_express_checkout']) }} as amex_express_checkout,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_base') }} as table_alias
-- wallet at payment_intents_base/last_payment_error/payment_method/card/wallet
where 1 = 1
and wallet is not null
{{ incremental_clause('_airbyte_emitted_at') }}

