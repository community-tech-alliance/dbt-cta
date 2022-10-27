{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_ab3') }}
select
    _airbyte_last_payment_error_hashid,
    id,
    eps,
    fpx,
    p24,
    card,
    oxxo,
    type,
    ideal,
    alipay,
    boleto,
    object,
    sofort,
    created,
    giropay,
    grabpay,
    customer,
    livemode,
    metadata,
    acss_debit,
    bacs_debit,
    bancontact,
    sepa_debit,
    wechat_pay,
    card_present,
    au_becs_debit,
    billing_details,
    interac_present,
    afterpay_clearpay,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payment_method_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_ab3') }}
-- payment_method at payment_intents/last_payment_error/payment_method from {{ ref('payment_intents_last_payment_error') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

