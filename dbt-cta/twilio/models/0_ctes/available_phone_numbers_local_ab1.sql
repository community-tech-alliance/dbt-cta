{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_available_phone_numbers_local') }}
select
    {{ json_extract_scalar('_airbyte_data', ['beta'], ['beta']) }} as beta,
    {{ json_extract_scalar('_airbyte_data', ['lata'], ['lata']) }} as lata,
    {{ json_extract_scalar('_airbyte_data', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['locality'], ['locality']) }} as locality,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['iso_country'], ['iso_country']) }} as iso_country,
    {{ json_extract_scalar('_airbyte_data', ['postal_code'], ['postal_code']) }} as postal_code,
    {{ json_extract_scalar('_airbyte_data', ['rate_center'], ['rate_center']) }} as rate_center,
    {{ json_extract('table_alias', '_airbyte_data', ['capabilities'], ['capabilities']) }} as capabilities,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['friendly_name'], ['friendly_name']) }} as friendly_name,
    {{ json_extract_scalar('_airbyte_data', ['address_requirements'], ['address_requirements']) }} as address_requirements,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_available_phone_numbers_local') }} as table_alias
-- available_phone_numbers_local
where 1 = 1

