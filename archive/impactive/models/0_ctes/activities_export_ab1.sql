{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_activities_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['performs'], ['performs']) }} as performs,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['completions'], ['completions']) }} as completions,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['started'], ['started']) }} as started,
    {{ json_extract_scalar('_airbyte_data', ['folder_name'], ['folder_name']) }} as folder_name,
    {{ json_extract_scalar('_airbyte_data', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['seen'], ['seen']) }} as seen,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['privacy_setting'], ['privacy_setting']) }} as privacy_setting,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['contact_list_id'], ['contact_list_id']) }} as contact_list_id,
    {{ json_extract_scalar('_airbyte_data', ['contact_list_name'], ['contact_list_name']) }} as contact_list_name,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['clicks'], ['clicks']) }} as clicks,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['aasm_state'], ['aasm_state']) }} as aasm_state,
    {{ json_extract_scalar('_airbyte_data', ['folder_id'], ['folder_id']) }} as folder_id,
    {{ json_extract_scalar('_airbyte_data', ['published_at'], ['published_at']) }} as published_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_activities_export') }} as table_alias
-- activities_export
where 1 = 1

