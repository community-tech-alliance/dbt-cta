{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_checkout_sessions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['mode'], ['mode']) }} as mode,
    {{ json_extract_scalar('_airbyte_data', ['locale'], ['locale']) }} as locale,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract('table_alias', '_airbyte_data', ['consent'], ['consent']) }} as consent,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', '_airbyte_data', ['shipping'], ['shipping']) }} as shipping,
    {{ json_extract_scalar('_airbyte_data', ['cancel_url'], ['cancel_url']) }} as cancel_url,
    {{ json_extract_scalar('_airbyte_data', ['expires_at'], ['expires_at']) }} as expires_at,
    {{ json_extract_scalar('_airbyte_data', ['submit_type'], ['submit_type']) }} as submit_type,
    {{ json_extract_scalar('_airbyte_data', ['success_url'], ['success_url']) }} as success_url,
    {{ json_extract_scalar('_airbyte_data', ['amount_total'], ['amount_total']) }} as amount_total,
    {{ json_extract_scalar('_airbyte_data', ['setup_intent'], ['setup_intent']) }} as setup_intent,
    {{ json_extract_scalar('_airbyte_data', ['subscription'], ['subscription']) }} as subscription,
    {{ json_extract('table_alias', '_airbyte_data', ['automatic_tax'], ['automatic_tax']) }} as automatic_tax,
    {{ json_extract('table_alias', '_airbyte_data', ['total_details'], ['total_details']) }} as total_details,
    {{ json_extract_scalar('_airbyte_data', ['customer_email'], ['customer_email']) }} as customer_email,
    {{ json_extract_scalar('_airbyte_data', ['payment_intent'], ['payment_intent']) }} as payment_intent,
    {{ json_extract_scalar('_airbyte_data', ['payment_status'], ['payment_status']) }} as payment_status,
    {{ json_extract_scalar('_airbyte_data', ['recovered_from'], ['recovered_from']) }} as recovered_from,
    {{ json_extract_scalar('_airbyte_data', ['amount_subtotal'], ['amount_subtotal']) }} as amount_subtotal,
    {{ json_extract('table_alias', '_airbyte_data', ['after_expiration'], ['after_expiration']) }} as after_expiration,
    {{ json_extract('table_alias', '_airbyte_data', ['customer_details'], ['customer_details']) }} as customer_details,
    {{ json_extract('table_alias', '_airbyte_data', ['tax_id_collection'], ['tax_id_collection']) }} as tax_id_collection,
    {{ json_extract('table_alias', '_airbyte_data', ['consent_collection'], ['consent_collection']) }} as consent_collection,
    {{ json_extract_scalar('_airbyte_data', ['client_reference_id'], ['client_reference_id']) }} as client_reference_id,
    {{ json_extract_array('_airbyte_data', ['payment_method_types'], ['payment_method_types']) }} as payment_method_types,
    {{ json_extract_scalar('_airbyte_data', ['allow_promotion_codes'], ['allow_promotion_codes']) }} as allow_promotion_codes,
    {{ json_extract('table_alias', '_airbyte_data', ['payment_method_options'], ['payment_method_options']) }} as payment_method_options,
    {{ json_extract('table_alias', '_airbyte_data', ['phone_number_collection'], ['phone_number_collection']) }} as phone_number_collection,
    {{ json_extract_scalar('_airbyte_data', ['billing_address_collection'], ['billing_address_collection']) }} as billing_address_collection,
    {{ json_extract('table_alias', '_airbyte_data', ['shipping_address_collection'], ['shipping_address_collection']) }} as shipping_address_collection,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_checkout_sessions') }} as table_alias
-- checkout_sessions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

