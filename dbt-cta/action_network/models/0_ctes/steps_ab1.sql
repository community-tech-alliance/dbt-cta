{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_steps') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['rules'], ['rules']) }} as rules,
    {{ json_extract_scalar('_airbyte_data', ['ladder_id'], ['ladder_id']) }} as ladder_id,
    {{ json_extract_scalar('_airbyte_data', ['step_type'], ['step_type']) }} as step_type,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['next_step_id'], ['next_step_id']) }} as next_step_id,
    {{ json_extract_scalar('_airbyte_data', ['alternate_next_step_id'], ['alternate_next_step_id']) }} as alternate_next_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_steps') }} as table_alias
-- steps
where 1 = 1

