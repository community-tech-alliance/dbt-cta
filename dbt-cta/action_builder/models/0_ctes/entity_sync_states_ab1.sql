{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_entity_sync_states') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['last_run'], ['last_run']) }} as last_run,
    {{ json_extract_scalar('_airbyte_data', ['entity_id'], ['entity_id']) }} as entity_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['comparable_id'], ['comparable_id']) }} as comparable_id,
    {{ json_extract_scalar('_airbyte_data', ['comparable_type'], ['comparable_type']) }} as comparable_type,
    {{ json_extract_scalar('_airbyte_data', ['external_entity_id'], ['external_entity_id']) }} as external_entity_id,
    {{ json_extract_scalar('_airbyte_data', ['external_compared_id'], ['external_compared_id']) }} as external_compared_id,
    {{ json_extract_scalar('_airbyte_data', ['external_compared_type'], ['external_compared_type']) }} as external_compared_type,
    {{ json_extract_scalar('_airbyte_data', ['service_integration_type'], ['service_integration_type']) }} as service_integration_type,
    {{ json_extract_scalar('_airbyte_data', ['organization_integration_id'], ['organization_integration_id']) }} as organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_entity_sync_states') }} as table_alias
-- entity_sync_states
where 1 = 1

