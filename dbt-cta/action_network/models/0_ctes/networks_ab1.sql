{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_networks" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['terms'], ['terms']) }} as terms,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['sms_enabled'], ['sms_enabled']) }} as sms_enabled,
    {{ json_extract_scalar('_airbyte_data', ['ip_pool_name'], ['ip_pool_name']) }} as ip_pool_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['csv_updated_at'], ['csv_updated_at']) }} as csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['lock_custom_fields'], ['lock_custom_fields']) }} as lock_custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['top_level_group_id'], ['top_level_group_id']) }} as top_level_group_id,
    {{ json_extract_scalar('_airbyte_data', ['opted_in_mobile_number'], ['opted_in_mobile_number']) }} as opted_in_mobile_number,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- networks
where 1 = 1
