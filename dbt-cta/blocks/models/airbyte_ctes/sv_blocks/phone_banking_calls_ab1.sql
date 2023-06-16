{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_phone_banking_calls') }}
select
    {{ json_extract_scalar('_airbyte_data', ['phone_bank_id'], ['phone_bank_id']) }} as phone_bank_id,
    {{ json_extract_scalar('_airbyte_data', ['round_canvass_status'], ['round_canvass_status']) }} as round_canvass_status,
    {{ json_extract_scalar('_airbyte_data', ['called_by_user_id'], ['called_by_user_id']) }} as called_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['participated'], ['participated']) }} as participated,
    {{ json_extract_scalar('_airbyte_data', ['twilio_call_id'], ['twilio_call_id']) }} as twilio_call_id,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['non_participation_reason'], ['non_participation_reason']) }} as non_participation_reason,
    {{ json_extract_scalar('_airbyte_data', ['external'], ['external']) }} as external,
    {{ json_extract_scalar('_airbyte_data', ['round'], ['round']) }} as round,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['locked_at'], ['locked_at']) }} as locked_at,
    {{ json_extract_scalar('_airbyte_data', ['locked_by_user_id'], ['locked_by_user_id']) }} as locked_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_phone_banking_calls') }} as table_alias
-- phone_banking_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

