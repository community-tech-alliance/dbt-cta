{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_actions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['text'], ['text']) }} as text,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['due_date'], ['due_date']) }} as due_date,
    {{ json_extract_scalar('_airbyte_data', ['completed'], ['completed']) }} as completed,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['created_by_id'], ['created_by_id']) }} as created_by_id,
    {{ json_extract_scalar('_airbyte_data', ['entity_type_id'], ['entity_type_id']) }} as entity_type_id,
    {{ json_extract_scalar('_airbyte_data', ['quick_check_in'], ['quick_check_in']) }} as quick_check_in,
    {{ json_extract_scalar('_airbyte_data', ['canvassing_type'], ['canvassing_type']) }} as canvassing_type,
    {{ json_extract_scalar('_airbyte_data', ['canvassing_enabled'], ['canvassing_enabled']) }} as canvassing_enabled,
    {{ json_extract_scalar('_airbyte_data', ['targets_query_json'], ['targets_query_json']) }} as targets_query_json,
    {{ json_extract_scalar('_airbyte_data', ['notification_enabled'], ['notification_enabled']) }} as notification_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_actions') }}
-- actions
where 1 = 1
