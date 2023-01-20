{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_tag') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['author_id'], ['author_id']) }} as author_id,
    {{ json_extract_scalar('_airbyte_data', ['is_system'], ['is_system']) }} as is_system,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['deleted_at'], ['deleted_at']) }} as deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['text_color'], ['text_color']) }} as text_color,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['webhook_url'], ['webhook_url']) }} as webhook_url,
    {{ json_extract_scalar('_airbyte_data', ['is_assignable'], ['is_assignable']) }} as is_assignable,
    {{ json_extract_scalar('_airbyte_data', ['on_apply_script'], ['on_apply_script']) }} as on_apply_script,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['background_color'], ['background_color']) }} as background_color,
    {{ json_extract_array('_airbyte_data', ['confirmation_steps'], ['confirmation_steps']) }} as confirmation_steps,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_tag') }} as table_alias
-- tag
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

