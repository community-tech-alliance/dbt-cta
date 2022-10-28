{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_customers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_array('_airbyte_data', ['cards'], ['cards']) }} as cards,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract('table_alias', '_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['balance'], ['balance']) }} as balance,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract('table_alias', '_airbyte_data', ['sources']) }} as sources,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', '_airbyte_data', ['discount'], ['discount']) }} as discount,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', '_airbyte_data', ['shipping'], ['shipping']) }} as shipping,
    {{ json_extract_scalar('_airbyte_data', ['tax_info'], ['tax_info']) }} as tax_info,
    {{ json_extract_scalar('_airbyte_data', ['delinquent'], ['delinquent']) }} as delinquent,
    {{ json_extract_scalar('_airbyte_data', ['tax_exempt'], ['tax_exempt']) }} as tax_exempt,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['default_card'], ['default_card']) }} as default_card,
    {{ json_extract('table_alias', '_airbyte_data', ['subscriptions'], ['subscriptions']) }} as subscriptions,
    {{ json_extract_scalar('_airbyte_data', ['default_source'], ['default_source']) }} as default_source,
    {{ json_extract_scalar('_airbyte_data', ['invoice_prefix'], ['invoice_prefix']) }} as invoice_prefix,
    {{ json_extract_scalar('_airbyte_data', ['account_balance'], ['account_balance']) }} as account_balance,
    {{ json_extract('table_alias', '_airbyte_data', ['invoice_settings'], ['invoice_settings']) }} as invoice_settings,
    {{ json_extract_string_array('_airbyte_data', ['preferred_locales'], ['preferred_locales']) }} as preferred_locales,
    {{ json_extract_scalar('_airbyte_data', ['next_invoice_sequence'], ['next_invoice_sequence']) }} as next_invoice_sequence,
    {{ json_extract_scalar('_airbyte_data', ['tax_info_verification'], ['tax_info_verification']) }} as tax_info_verification,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_customers') }} as table_alias
-- customers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

