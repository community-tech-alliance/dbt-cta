{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_external_account_cards') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('_airbyte_data', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['account'], ['account']) }} as account,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar('_airbyte_data', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['cvc_check'], ['cvc_check']) }} as cvc_check,
    {{ json_extract_scalar('_airbyte_data', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar('_airbyte_data', ['redaction'], ['redaction']) }} as redaction,
    {{ json_extract_scalar('_airbyte_data', ['address_zip'], ['address_zip']) }} as address_zip,
    {{ json_extract_scalar('_airbyte_data', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('_airbyte_data', ['address_city'], ['address_city']) }} as address_city,
    {{ json_extract_scalar('_airbyte_data', ['address_line1'], ['address_line1']) }} as address_line1,
    {{ json_extract_scalar('_airbyte_data', ['address_line2'], ['address_line2']) }} as address_line2,
    {{ json_extract_scalar('_airbyte_data', ['address_state'], ['address_state']) }} as address_state,
    {{ json_extract_scalar('_airbyte_data', ['dynamic_last4'], ['dynamic_last4']) }} as dynamic_last4,
    {{ json_extract_scalar('_airbyte_data', ['address_country'], ['address_country']) }} as address_country,
    {{ json_extract_scalar('_airbyte_data', ['address_zip_check'], ['address_zip_check']) }} as address_zip_check,
    {{ json_extract_scalar('_airbyte_data', ['address_line1_check'], ['address_line1_check']) }} as address_line1_check,
    {{ json_extract_scalar('_airbyte_data', ['tokenization_method'], ['tokenization_method']) }} as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_external_account_cards') }} as table_alias
-- external_account_cards
where 1 = 1

