{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab3') }}
select
    _airbyte_payment_method_details_hashid,
    type,
    brand,
    lsat4,
    country,
    funding,
    network,
    receipt,
    exp_year,
    exp_month,
    fingerprint,
    read_method,
    emv_auth_data,
    generated_card,
    cardholder_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_present_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab3') }}
-- card_present at payment_intents/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

