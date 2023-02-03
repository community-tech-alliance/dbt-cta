{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_user_merge_logs_1') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('_airbyte_data', ['list_type'], ['list_type']) }} as list_type,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['merged_user_id'], ['merged_user_id']) }} as merged_user_id,
    {{ json_extract_scalar('_airbyte_data', ['removed_user_id'], ['removed_user_id']) }} as removed_user_id,
    {{ json_extract_scalar('_airbyte_data', ['merged_user_email'], ['merged_user_email']) }} as merged_user_email,
    {{ json_extract_scalar('_airbyte_data', ['removed_user_email'], ['removed_user_email']) }} as removed_user_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_user_merge_logs_1') }} as table_alias
-- user_merge_logs_1
where 1 = 1

