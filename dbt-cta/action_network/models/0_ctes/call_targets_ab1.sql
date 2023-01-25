{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_call_targets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['bioid'], ['bioid']) }} as bioid,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['call_id'], ['call_id']) }} as call_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['target_name'], ['target_name']) }} as target_name,
    {{ json_extract_scalar('_airbyte_data', ['target_type'], ['target_type']) }} as target_type,
    {{ json_extract_scalar('_airbyte_data', ['target_party'], ['target_party']) }} as target_party,
    {{ json_extract_scalar('_airbyte_data', ['target_phone'], ['target_phone']) }} as target_phone,
    {{ json_extract_scalar('_airbyte_data', ['target_state'], ['target_state']) }} as target_state,
    {{ json_extract_scalar('_airbyte_data', ['call_duration'], ['call_duration']) }} as call_duration,
    {{ json_extract_scalar('_airbyte_data', ['target_country'], ['target_country']) }} as target_country,
    {{ json_extract_scalar('_airbyte_data', ['target_district'], ['target_district']) }} as target_district,
    {{ json_extract_scalar('_airbyte_data', ['target_position'], ['target_position']) }} as target_position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_call_targets') }} as table_alias
-- call_targets
where 1 = 1

