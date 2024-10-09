{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_conversion_trackers" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['conv_type'], ['conv_type']) }} as conv_type,
    {{ json_extract_scalar('_airbyte_data', ['post_time'], ['post_time']) }} as post_time,
    {{ json_extract_scalar('_airbyte_data', ['count_type'], ['count_type']) }} as count_type,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- conversion_trackers
where 1 = 1
