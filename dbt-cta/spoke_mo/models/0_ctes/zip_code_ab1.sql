{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_zip_code" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['timezone_offset'], ['timezone_offset']) }} as timezone_offset,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['has_dst'], ['has_dst']) }} as has_dst,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- zip_code
where 1 = 1
