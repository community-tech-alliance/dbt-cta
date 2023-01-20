{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_user') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['cell'], ['cell']) }} as cell,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['terms'], ['terms']) }} as terms,
    {{ json_extract_scalar('_airbyte_data', ['auth0_id'], ['auth0_id']) }} as auth0_id,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['is_suspended'], ['is_suspended']) }} as is_suspended,
    {{ json_extract_scalar('_airbyte_data', ['assigned_cell'], ['assigned_cell']) }} as assigned_cell,
    {{ json_extract_scalar('_airbyte_data', ['is_superadmin'], ['is_superadmin']) }} as is_superadmin,
    {{ json_extract_scalar('_airbyte_data', ['notification_frequency'], ['notification_frequency']) }} as notification_frequency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_user') }} as table_alias
-- user
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

