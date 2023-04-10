{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_base') }}
select
    _airbyte_card_present_hashid,
    {{ json_extract_scalar('receipt', ['account_type'], ['account_type']) }} as account_type,
    {{ json_extract_scalar('receipt', ['authorization_code'], ['authorization_code']) }} as authorization_code,
    {{ json_extract_scalar('receipt', ['dedicated_file_name'], ['dedicated_file_name']) }} as dedicated_file_name,
    {{ json_extract_scalar('receipt', ['application_cryptogram'], ['application_cryptogram']) }} as application_cryptogram,
    {{ json_extract_scalar('receipt', ['application_preferred_name'], ['application_preferred_name']) }} as application_preferred_name,
    {{ json_extract_scalar('receipt', ['authorization_response_code'], ['authorization_response_code']) }} as authorization_response_code,
    {{ json_extract_scalar('receipt', ['terminal_verification_results'], ['terminal_verification_results']) }} as terminal_verification_results,
    {{ json_extract_scalar('receipt', ['cardholder_verification_method'], ['cardholder_verification_method']) }} as cardholder_verification_method,
    {{ json_extract_scalar('receipt', ['transaction_status_information'], ['transaction_status_information']) }} as transaction_status_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_base') }} as table_alias
-- receipt at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present/receipt
where 1 = 1
and receipt is not null
{{ incremental_clause('_airbyte_emitted_at') }}

