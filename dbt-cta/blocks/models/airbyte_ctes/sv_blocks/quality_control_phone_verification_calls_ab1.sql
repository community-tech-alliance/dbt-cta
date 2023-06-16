{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_quality_control_phone_verification_calls') }}
select
    {{ json_extract_scalar('_airbyte_data', ['number'], ['number']) }} as number,
    {{ json_extract_scalar('_airbyte_data', ['external'], ['external']) }} as external,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_scan_id'], ['voter_registration_scan_id']) }} as voter_registration_scan_id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['twilio_call_id'], ['twilio_call_id']) }} as twilio_call_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['disconnected_at'], ['disconnected_at']) }} as disconnected_at,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_quality_control_phone_verification_calls') }} as table_alias
-- quality_control_phone_verification_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

