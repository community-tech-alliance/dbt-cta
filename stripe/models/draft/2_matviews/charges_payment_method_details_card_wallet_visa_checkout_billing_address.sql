{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_visa_checkout_billing_address_ab3') }}
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
from {{ ref('charges_payment_method_details_card_wallet_visa_checkout_billing_address_ab3') }}
-- billing_address at charges_base/payment_method_details/card/wallet/visa_checkout/billing_address from {{ ref('charges_payment_method_details_card_wallet_visa_checkout_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

