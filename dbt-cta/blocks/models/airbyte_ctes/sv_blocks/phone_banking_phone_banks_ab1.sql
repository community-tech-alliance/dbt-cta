{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_phone_banking_phone_banks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['end_date'], ['end_date']) }} as end_date,
    {{ json_extract_scalar('_airbyte_data', ['daily_end_time'], ['daily_end_time']) }} as daily_end_time,
    {{ json_extract_scalar('_airbyte_data', ['min_call_delay_in_hours'], ['min_call_delay_in_hours']) }} as min_call_delay_in_hours,
    {{ json_extract_scalar('_airbyte_data', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['script_id'], ['script_id']) }} as script_id,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['archived'], ['archived']) }} as archived,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['closed'], ['closed']) }} as closed,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['current_round'], ['current_round']) }} as current_round,
    {{ json_extract_scalar('_airbyte_data', ['call_type'], ['call_type']) }} as call_type,
    {{ json_extract_scalar('_airbyte_data', ['daily_start_time'], ['daily_start_time']) }} as daily_start_time,
    {{ json_extract_scalar('_airbyte_data', ['number_of_rounds'], ['number_of_rounds']) }} as number_of_rounds,
    {{ json_extract_scalar('_airbyte_data', ['start_date'], ['start_date']) }} as start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_phone_banking_phone_banks') }} as table_alias
-- phone_banking_phone_banks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

