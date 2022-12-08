{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_locations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['mcc'], ['mcc']) }} as mcc,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract('table_alias', '_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['merchant_id'], ['merchant_id']) }} as merchant_id,
    {{ json_extract_scalar('_airbyte_data', ['website_url'], ['website_url']) }} as website_url,
    {{ json_extract_string_array('_airbyte_data', ['capabilities'], ['capabilities']) }} as capabilities,
    {{ json_extract_scalar('_airbyte_data', ['facebook_url'], ['facebook_url']) }} as facebook_url,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['business_name'], ['business_name']) }} as business_name,
    {{ json_extract_scalar('_airbyte_data', ['language_code'], ['language_code']) }} as language_code,
    {{ json_extract_scalar('_airbyte_data', ['business_email'], ['business_email']) }} as business_email,
    {{ json_extract('table_alias', '_airbyte_data', ['business_hours'], ['business_hours']) }} as business_hours,
    {{ json_extract_scalar('_airbyte_data', ['twitter_username'], ['twitter_username']) }} as twitter_username,
    {{ json_extract_scalar('_airbyte_data', ['instagram_username'], ['instagram_username']) }} as instagram_username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_locations') }} as table_alias
-- locations
where 1 = 1

