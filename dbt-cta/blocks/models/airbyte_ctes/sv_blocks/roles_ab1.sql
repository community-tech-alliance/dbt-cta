{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_roles') }}
select
    {{ json_extract_scalar('_airbyte_data', ['needs_training'], ['needs_training']) }} as needs_training,
    {{ json_extract_scalar('_airbyte_data', ['admin'], ['admin']) }} as admin,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['abilities'], ['abilities']) }} as abilities,
    {{ json_extract_scalar('_airbyte_data', ['depth'], ['depth']) }} as depth,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['permissions'], ['permissions']) }} as permissions,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['lft'], ['lft']) }} as lft,
    {{ json_extract_scalar('_airbyte_data', ['rgt'], ['rgt']) }} as rgt,
    {{ json_extract_scalar('_airbyte_data', ['dashboard_layout_id'], ['dashboard_layout_id']) }} as dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_roles') }} as table_alias
-- roles
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

