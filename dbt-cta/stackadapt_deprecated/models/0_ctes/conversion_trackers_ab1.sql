{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_conversion_trackers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['conv_type'], ['conv_type']) }} as conv_type,
    {{ json_extract_scalar('_airbyte_data', ['post_time'], ['post_time']) }} as post_time,
    {{ json_extract_scalar('_airbyte_data', ['count_type'], ['count_type']) }} as count_type,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_conversion_trackers') }} as table_alias
-- conversion_trackers
where 1 = 1

