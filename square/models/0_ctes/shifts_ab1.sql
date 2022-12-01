{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_shifts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['wage'], ['wage']) }} as wage,
    {{ json_extract_array('_airbyte_data', ['breaks'], ['breaks']) }} as breaks,
    {{ json_extract_scalar('_airbyte_data', ['end_at'], ['end_at']) }} as end_at,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('_airbyte_data', ['start_at'], ['start_at']) }} as start_at,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['employee_id'], ['employee_id']) }} as employee_id,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract_scalar('_airbyte_data', ['team_member_id'], ['team_member_id']) }} as team_member_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_shifts') }} as table_alias
-- shifts
where 1 = 1

