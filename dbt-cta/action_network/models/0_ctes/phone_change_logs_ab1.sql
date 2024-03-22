{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_phone_change_logs" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['owner_id'], ['owner_id']) }} as owner_id,
    {{ json_extract_scalar('_airbyte_data', ['new_phone'], ['new_phone']) }} as new_phone,
    {{ json_extract_scalar('_airbyte_data', ['old_phone'], ['old_phone']) }} as old_phone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['owner_type'], ['owner_type']) }} as owner_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['source_action_id'], ['source_action_id']) }} as source_action_id,
    {{ json_extract_scalar('_airbyte_data', ['source_action_type'], ['source_action_type']) }} as source_action_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- phone_change_logs
where 1 = 1
