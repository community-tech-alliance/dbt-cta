{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_team') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['author_id'], ['author_id']) }} as author_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['text_color'], ['text_color']) }} as text_color,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['assignment_type'], ['assignment_type']) }} as assignment_type,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['background_color'], ['background_color']) }} as background_color,
    {{ json_extract_scalar('_airbyte_data', ['max_request_count'], ['max_request_count']) }} as max_request_count,
    {{ json_extract_scalar('_airbyte_data', ['assignment_priority'], ['assignment_priority']) }} as assignment_priority,
    {{ json_extract_scalar('_airbyte_data', ['is_assignment_enabled'], ['is_assignment_enabled']) }} as is_assignment_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_team') }} as table_alias
-- team
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

