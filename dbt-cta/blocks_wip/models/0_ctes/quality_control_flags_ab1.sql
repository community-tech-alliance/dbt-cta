{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_quality_control_flags') }}
select
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_id'], ['canvasser_id']) }} as canvasser_id,
    {{ json_extract_scalar('_airbyte_data', ['trigger_id'], ['trigger_id']) }} as trigger_id,
    {{ json_extract_scalar('_airbyte_data', ['reviewed_at'], ['reviewed_at']) }} as reviewed_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['completed_at'], ['completed_at']) }} as completed_at,
    {{ json_extract_scalar('_airbyte_data', ['ready_at'], ['ready_at']) }} as ready_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['packet_id'], ['packet_id']) }} as packet_id,
    {{ json_extract_scalar('_airbyte_data', ['action_plan'], ['action_plan']) }} as action_plan,
    {{ json_extract_scalar('_airbyte_data', ['triggered_by_shift_id'], ['triggered_by_shift_id']) }} as triggered_by_shift_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_quality_control_flags') }} as table_alias
-- quality_control_flags
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

