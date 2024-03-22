{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_user_files" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', 'raw_table') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['file_type'], ['file_type']) }} as file_type,
    {{ json_extract_scalar('_airbyte_data', ['mime_type'], ['mime_type']) }} as mime_type,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['download_number'], ['download_number']) }} as download_number,
    {{ json_extract_scalar('_airbyte_data', ['user_file_file_name'], ['user_file_file_name']) }} as user_file_file_name,
    {{ json_extract_scalar('_airbyte_data', ['user_file_file_size'], ['user_file_file_size']) }} as user_file_file_size,
    {{ json_extract_scalar('_airbyte_data', ['user_file_content_type'], ['user_file_content_type']) }} as user_file_content_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', 'raw_table') }}
-- user_files
where 1 = 1
