{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_meetings') }}
select
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['guest_attended'], ['guest_attended']) }} as guest_attended,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['cancelled'], ['cancelled']) }} as cancelled,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_meetings') }}
-- meetings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

