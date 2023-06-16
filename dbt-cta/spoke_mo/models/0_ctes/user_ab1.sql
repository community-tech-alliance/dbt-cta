{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_user') }}
select
    {{ json_extract_scalar('_airbyte_data', ['terms'], ['terms']) }} as terms,
    {{ json_extract_scalar('_airbyte_data', ['extra'], ['extra']) }} as extra,
    {{ json_extract_scalar('_airbyte_data', ['assigned_cell'], ['assigned_cell']) }} as assigned_cell,
    {{ json_extract_scalar('_airbyte_data', ['alias'], ['alias']) }} as alias,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['cell'], ['cell']) }} as cell,
    {{ json_extract_scalar('_airbyte_data', ['auth0_id'], ['auth0_id']) }} as auth0_id,
    {{ json_extract_scalar('_airbyte_data', ['is_superadmin'], ['is_superadmin']) }} as is_superadmin,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_user') }} as table_alias
-- user
where 1 = 1


