{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_ab3') }}
select
    _airbyte_payment_method_details_hashid,
    id,
    eps,
    p24,
    name,
    type,
    brand,
    ideal,
    last4,
    checks,
    klarna,
    object,
    sofort,
    wallet,
    wechat,
    country,
    funding,
    giropay,
    network,
    customer,
    exp_year,
    metadata,
    cvc_check,
    exp_month,
    multibanco,
    sepa_debit,
    address_zip,
    fingerprint,
    address_city,
    card_present,
    installments,
    address_line1,
    address_line2,
    address_state,
    dynamic_last4,
    stripe_account,
    three_d_secure,
    address_country,
    address_zip_check,
    address_line1_check,
    tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_hashid
from {{ ref('charges_payment_method_details_card_ab3') }}
-- card at charges/payment_method_details/card from {{ ref('charges_payment_method_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

