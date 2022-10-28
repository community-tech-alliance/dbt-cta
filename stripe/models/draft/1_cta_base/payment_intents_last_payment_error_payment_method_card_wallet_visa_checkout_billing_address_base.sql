{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_billing_address_ab3') }}
select
    _airbyte_visa_checkout_hashid,
    city,
    line1,
    line2,
    state,
    country,
    postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_billing_address_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_billing_address_ab3') }}
-- billing_address at payment_intents/last_payment_error/payment_method/card/wallet/visa_checkout/billing_address from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

