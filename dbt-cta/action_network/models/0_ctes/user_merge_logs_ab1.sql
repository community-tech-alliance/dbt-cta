
{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_user_merge_logs" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- user_merge_logs
where 1 = 1
