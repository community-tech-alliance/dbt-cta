{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card_card_present') }}
select
    _airbyte_card_present_hashid,
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
from {{ ref('charges_payment_method_details_card_card_present') }} as table_alias
-- receipt at charges_base/payment_method_details/card/card_present/receipt
where 1 = 1
and receipt is not null
{{ incremental_clause('_airbyte_emitted_at') }}

