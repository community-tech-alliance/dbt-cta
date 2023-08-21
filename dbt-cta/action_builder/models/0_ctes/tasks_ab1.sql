{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tasks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['resolved'], ['resolved']) }} as resolved,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['object_ref'], ['object_ref']) }} as object_ref,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['resolved_at'], ['resolved_at']) }} as resolved_at,
    {{ json_extract_scalar('_airbyte_data', ['resolved_by_id'], ['resolved_by_id']) }} as resolved_by_id,
    {{ json_extract_scalar('_airbyte_data', ['action_field_id'], ['action_field_id']) }} as action_field_id,
    {{ json_extract_scalar('_airbyte_data', ['action_entity_id'], ['action_entity_id']) }} as action_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tasks') }}
-- tasks
where 1 = 1
