{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_schedules') }}
select
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['count'], ['count']) }} as count,
    {{ json_extract_scalar('_airbyte_data', ['rule'], ['rule']) }} as rule,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['schedulable_type'], ['schedulable_type']) }} as schedulable_type,
    {{ json_extract_scalar('_airbyte_data', ['schedulable_id'], ['schedulable_id']) }} as schedulable_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['until'], ['until']) }} as until,
    {{ json_extract_scalar('_airbyte_data', ['interval'], ['interval']) }} as {{ adapter.quote('interval') }},
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['time'], ['time']) }} as time,
    {{ json_extract_scalar('_airbyte_data', ['day'], ['day']) }} as day,
    {{ json_extract_scalar('_airbyte_data', ['day_of_week'], ['day_of_week']) }} as day_of_week,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_schedules') }}
-- schedules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

