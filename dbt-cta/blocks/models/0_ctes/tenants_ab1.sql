{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tenants') }}
select
    {{ json_extract_scalar('_airbyte_data', ['contact_phone'], ['contact_phone']) }} as contact_phone,
    {{ json_extract_scalar('_airbyte_data', ['logo_data'], ['logo_data']) }} as logo_data,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_string_array('_airbyte_data', ['leaderboard_metrics'], ['leaderboard_metrics']) }} as leaderboard_metrics,
    {{ json_extract_scalar('_airbyte_data', ['logo_old'], ['logo_old']) }} as logo_old,
    {{ json_extract_scalar('_airbyte_data', ['contact_email'], ['contact_email']) }} as contact_email,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_string_array('_airbyte_data', ['shift_times'], ['shift_times']) }} as shift_times,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['options'], ['options']) }} as options,
    {{ json_extract_scalar('_airbyte_data', ['subdomain'], ['subdomain']) }} as subdomain,
    {{ json_extract_scalar('_airbyte_data', ['contact_last_name'], ['contact_last_name']) }} as contact_last_name,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['contact_first_name'], ['contact_first_name']) }} as contact_first_name,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tenants') }}
-- tenants
