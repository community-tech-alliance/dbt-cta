{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_ab3') }}
select
    _airbyte_wallet_hashid,
    name,
    email,
    billing_address,
    shipping_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_visa_checkout_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_ab3') }}
-- visa_checkout at payment_intents/last_payment_error/payment_method/card/wallet/visa_checkout from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

