{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tasks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['date_due'], ['date_due']) }} as date_due,
    {{ json_extract_scalar('_airbyte_data', ['owner_id'], ['owner_id']) }} as owner_id,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['opener_name'], ['opener_name']) }} as opener_name,
    {{ json_extract_scalar('_airbyte_data', ['object_id'], ['object_id']) }} as object_id,
    {{ json_extract_scalar('_airbyte_data', ['assignee_name'], ['assignee_name']) }} as assignee_name,
    {{ json_extract_scalar('_airbyte_data', ['due_whenever'], ['due_whenever']) }} as due_whenever,
    {{ json_extract_scalar('_airbyte_data', ['time_created'], ['time_created']) }} as time_created,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['assignee_id'], ['assignee_id']) }} as assignee_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tasks') }} as table_alias
-- tasks
where 1 = 1

