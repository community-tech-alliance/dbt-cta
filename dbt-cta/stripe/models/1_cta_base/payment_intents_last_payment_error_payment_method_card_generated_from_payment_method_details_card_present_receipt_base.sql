{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab3') }}
select
    _airbyte_card_present_hashid,
    account_type,
    authorization_code,
    dedicated_file_name,
    application_cryptogram,
    application_preferred_name,
    authorization_response_code,
    terminal_verification_results,
    cardholder_verification_method,
    transaction_status_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_receipt_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab3') }}
-- receipt at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present/receipt from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

