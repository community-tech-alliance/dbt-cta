{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_time_entries') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('_airbyte_data', ['agent_id'], ['agent_id']) }} as agent_id,
    {{ json_extract_scalar('_airbyte_data', ['billable'], ['billable']) }} as billable,
    {{ json_extract_scalar('_airbyte_data', ['ticket_id'], ['ticket_id']) }} as ticket_id,
    {{ json_extract_scalar('_airbyte_data', ['company_id'], ['company_id']) }} as company_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['time_spent'], ['time_spent']) }} as time_spent,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['executed_at'], ['executed_at']) }} as executed_at,
    {{ json_extract_scalar('_airbyte_data', ['timer_running'], ['timer_running']) }} as timer_running,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_time_entries') }} as table_alias
-- time_entries
where 1 = 1

