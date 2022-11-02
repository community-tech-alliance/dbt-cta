{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_agents') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', '_airbyte_data', ['contact'], ['contact']) }} as contact,
    {{ json_extract_scalar('_airbyte_data', ['available'], ['available']) }} as available,
    {{ json_extract_scalar('_airbyte_data', ['signature'], ['signature']) }} as signature,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['occasional'], ['occasional']) }} as occasional,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['ticket_scope'], ['ticket_scope']) }} as ticket_scope,
    {{ json_extract_scalar('_airbyte_data', ['last_active_at'], ['last_active_at']) }} as last_active_at,
    {{ json_extract_scalar('_airbyte_data', ['available_since'], ['available_since']) }} as available_since,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_agents') }} as table_alias
-- agents
where 1 = 1

