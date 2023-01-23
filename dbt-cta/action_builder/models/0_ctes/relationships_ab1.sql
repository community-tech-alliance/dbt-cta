{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_relationships') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['deleted'], ['deleted']) }} as deleted,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['deleted_at'], ['deleted_at']) }} as deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['to_entity_id'], ['to_entity_id']) }} as to_entity_id,
    {{ json_extract_scalar('_airbyte_data', ['created_by_id'], ['created_by_id']) }} as created_by_id,
    {{ json_extract_scalar('_airbyte_data', ['deleted_by_id'], ['deleted_by_id']) }} as deleted_by_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_by_id'], ['updated_by_id']) }} as updated_by_id,
    {{ json_extract_scalar('_airbyte_data', ['from_entity_id'], ['from_entity_id']) }} as from_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_relationships') }} as table_alias
-- relationships
where 1 = 1

