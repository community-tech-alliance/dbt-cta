{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_organization_integration_links') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['settings'], ['settings']) }} as settings,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['linkable_id'], ['linkable_id']) }} as linkable_id,
    {{ json_extract_scalar('_airbyte_data', ['linkable_type'], ['linkable_type']) }} as linkable_type,
    {{ json_extract_scalar('_airbyte_data', ['external_entity_id'], ['external_entity_id']) }} as external_entity_id,
    {{ json_extract_scalar('_airbyte_data', ['external_entity_type'], ['external_entity_type']) }} as external_entity_type,
    {{ json_extract_scalar('_airbyte_data', ['organization_integration_id'], ['organization_integration_id']) }} as organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_organization_integration_links') }} as table_alias
-- organization_integration_links
where 1 = 1

