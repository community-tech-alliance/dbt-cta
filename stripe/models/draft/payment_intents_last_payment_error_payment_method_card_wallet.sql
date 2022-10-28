{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab3') }}
select
    _airbyte_card_hashid,
    type,
    apple_pay,
    google_pay,
    masterpass,
    samsung_pay,
    dynamic_last4,
    visa_checkout,
    amex_express_checkout,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wallet_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab3') }}
-- wallet at payment_intents/last_payment_error/payment_method/card/wallet from {{ ref('payment_intents_last_payment_error_payment_method_card') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

