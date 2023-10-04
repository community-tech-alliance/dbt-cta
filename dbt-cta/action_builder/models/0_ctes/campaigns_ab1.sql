{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_campaigns') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['interact_id'], ['interact_id']) }} as interact_id,
    {{ json_extract_scalar('_airbyte_data', ['created_by_id'], ['created_by_id']) }} as created_by_id,
    {{ json_extract_scalar('_airbyte_data', ['target_number'], ['target_number']) }} as target_number,
    {{ json_extract_scalar('_airbyte_data', ['default_country'], ['default_country']) }} as default_country,
    {{ json_extract_scalar('_airbyte_data', ['show_custom_ids'], ['show_custom_ids']) }} as show_custom_ids,
    {{ json_extract_scalar('_airbyte_data', ['support_user_id'], ['support_user_id']) }} as support_user_id,
    {{ json_extract_scalar('_airbyte_data', ['toplines_settings'], ['toplines_settings']) }} as toplines_settings,
    {{ json_extract_scalar('_airbyte_data', ['default_entity_type_id'], ['default_entity_type_id']) }} as default_entity_type_id,
    {{ json_extract_scalar('_airbyte_data', ['show_electoral_districts'], ['show_electoral_districts']) }} as show_electoral_districts,
    {{ json_extract_scalar('_airbyte_data', ['allow_organizers_to_export'], ['allow_organizers_to_export']) }} as allow_organizers_to_export,
    {{ json_extract_scalar('_airbyte_data', ['restricted_exporting_settings'], ['restricted_exporting_settings']) }} as restricted_exporting_settings,
    {{ json_extract_scalar('_airbyte_data', ['activity_stream_as_initial_entity_view'], ['activity_stream_as_initial_entity_view']) }} as activity_stream_as_initial_entity_view,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_campaigns') }}
-- campaigns
where 1 = 1
