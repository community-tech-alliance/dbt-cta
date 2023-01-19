{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_organizations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['settings'], ['settings']) }} as settings,
    {{ json_extract_scalar('_airbyte_data', ['subdomain'], ['subdomain']) }} as subdomain,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['api_enabled'], ['api_enabled']) }} as api_enabled,
    {{ json_extract_scalar('_airbyte_data', ['country_code'], ['country_code']) }} as country_code,
    {{ json_extract_scalar('_airbyte_data', ['default_country'], ['default_country']) }} as default_country,
    {{ json_extract_scalar('_airbyte_data', ['administrator_user_id'], ['administrator_user_id']) }} as administrator_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_organizations') }} as table_alias
-- organizations
where 1 = 1

