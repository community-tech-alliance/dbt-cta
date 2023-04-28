{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_action_fields') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract_scalar('_airbyte_data', ['action_id'], ['action_id']) }} as action_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['is_optional'], ['is_optional']) }} as is_optional,
    {{ json_extract_scalar('_airbyte_data', ['object_type'], ['object_type']) }} as object_type,
    {{ json_extract_scalar('_airbyte_data', ['object_attribute'], ['object_attribute']) }} as object_attribute,
    {{ json_extract_scalar('_airbyte_data', ['related_object_id'], ['related_object_id']) }} as related_object_id,
    {{ json_extract_scalar('_airbyte_data', ['default_response_id'], ['default_response_id']) }} as default_response_id,
    {{ json_extract_scalar('_airbyte_data', ['related_object_type'], ['related_object_type']) }} as related_object_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_action_fields') }} as table_alias
-- action_fields
where 1 = 1

