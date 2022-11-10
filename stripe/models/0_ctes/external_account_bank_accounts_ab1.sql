{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_external_account_bank_accounts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['account'], ['account']) }} as account,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('_airbyte_data', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('_airbyte_data', ['account_type'], ['account_type']) }} as account_type,
    {{ json_extract_scalar('_airbyte_data', ['routing_number'], ['routing_number']) }} as routing_number,
    {{ json_extract_scalar('_airbyte_data', ['account_holder_name'], ['account_holder_name']) }} as account_holder_name,
    {{ json_extract_scalar('_airbyte_data', ['account_holder_type'], ['account_holder_type']) }} as account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_external_account_bank_accounts') }} as table_alias
-- external_account_bank_accounts
where 1 = 1

