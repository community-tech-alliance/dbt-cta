{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_events') }}
select
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract_scalar('_airbyte_data', ['event_type_id'], ['event_type_id']) }} as event_type_id,
    {{ json_extract_scalar('_airbyte_data', ['public'], ['public']) }} as public,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['public_page_header_data'], ['public_page_header_data']) }} as public_page_header_data,
    {{ json_extract_scalar('_airbyte_data', ['public_page_header_map_data'], ['public_page_header_map_data']) }} as public_page_header_map_data,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['invited_count'], ['invited_count']) }} as invited_count,
    {{ json_extract_scalar('_airbyte_data', ['no_show_count'], ['no_show_count']) }} as no_show_count,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['public_settings'], ['public_settings']) }} as public_settings,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['first_occurrence_id'], ['first_occurrence_id']) }} as first_occurrence_id,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['walk_in_count'], ['walk_in_count']) }} as walk_in_count,
    {{ json_extract_scalar('_airbyte_data', ['attended_count'], ['attended_count']) }} as attended_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_events') }}
-- events
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

