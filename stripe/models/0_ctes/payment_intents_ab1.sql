{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_payment_intents') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['review'], ['review']) }} as review,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract('table_alias', '_airbyte_data', ['charges'], ['charges']) }} as charges,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['invoice'], ['invoice']) }} as invoice,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', '_airbyte_data', ['shipping'], ['shipping']) }} as shipping,
    {{ json_extract_scalar('_airbyte_data', ['application'], ['application']) }} as application,
    {{ json_extract_scalar('_airbyte_data', ['canceled_at'], ['canceled_at']) }} as canceled_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract('table_alias', '_airbyte_data', ['next_action'], ['next_action']) }} as next_action,
    {{ json_extract_scalar('_airbyte_data', ['on_behalf_of'], ['on_behalf_of']) }} as on_behalf_of,
    {{ json_extract_scalar('_airbyte_data', ['client_secret'], ['client_secret']) }} as client_secret,
    {{ json_extract_scalar('_airbyte_data', ['receipt_email'], ['receipt_email']) }} as receipt_email,
    {{ json_extract('table_alias', '_airbyte_data', ['transfer_data'], ['transfer_data']) }} as transfer_data,
    {{ json_extract_scalar('_airbyte_data', ['capture_method'], ['capture_method']) }} as capture_method,
    {{ json_extract_scalar('_airbyte_data', ['payment_method'], ['payment_method']) }} as payment_method,
    {{ json_extract_scalar('_airbyte_data', ['transfer_group'], ['transfer_group']) }} as transfer_group,
    {{ json_extract_scalar('_airbyte_data', ['amount_received'], ['amount_received']) }} as amount_received,
    {{ json_extract_scalar('_airbyte_data', ['amount_capturable'], ['amount_capturable']) }} as amount_capturable,
    {{ json_extract('table_alias', '_airbyte_data', ['last_payment_error'], ['last_payment_error']) }} as last_payment_error,
    {{ json_extract_scalar('_airbyte_data', ['setup_future_usage'], ['setup_future_usage']) }} as setup_future_usage,
    {{ json_extract_scalar('_airbyte_data', ['cancellation_reason'], ['cancellation_reason']) }} as cancellation_reason,
    {{ json_extract_scalar('_airbyte_data', ['confirmation_method'], ['confirmation_method']) }} as confirmation_method,
    {{ json_extract_string_array('_airbyte_data', ['payment_method_types'], ['payment_method_types']) }} as payment_method_types,
    {{ json_extract_scalar('_airbyte_data', ['statement_description'], ['statement_description']) }} as statement_description,
    {{ json_extract_scalar('_airbyte_data', ['application_fee_amount'], ['application_fee_amount']) }} as application_fee_amount,
    {{ json_extract('table_alias', '_airbyte_data', ['payment_method_options'], ['payment_method_options']) }} as payment_method_options,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor_suffix'], ['statement_descriptor_suffix']) }} as statement_descriptor_suffix,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_payment_intents') }} as table_alias
-- payment_intents
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

