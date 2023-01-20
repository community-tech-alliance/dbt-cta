{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_all_campaign') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['due_by'], ['due_by']) }} as due_by,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['intro_html'], ['intro_html']) }} as intro_html,
    {{ json_extract_scalar('_airbyte_data', ['is_started'], ['is_started']) }} as is_started,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['is_approved'], ['is_approved']) }} as is_approved,
    {{ json_extract_scalar('_airbyte_data', ['is_archived'], ['is_archived']) }} as is_archived,
    {{ json_extract_scalar('_airbyte_data', ['is_template'], ['is_template']) }} as is_template,
    {{ json_extract_scalar('_airbyte_data', ['primary_color'], ['primary_color']) }} as primary_color,
    {{ json_extract_scalar('_airbyte_data', ['autosend_limit'], ['autosend_limit']) }} as autosend_limit,
    {{ json_extract_scalar('_airbyte_data', ['logo_image_url'], ['logo_image_url']) }} as logo_image_url,
    {{ json_extract_scalar('_airbyte_data', ['autosend_status'], ['autosend_status']) }} as autosend_status,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['autosend_user_id'], ['autosend_user_id']) }} as autosend_user_id,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_end'], ['texting_hours_end']) }} as texting_hours_end,
    {{ json_extract_scalar('_airbyte_data', ['external_system_id'], ['external_system_id']) }} as external_system_id,
    {{ json_extract_scalar('_airbyte_data', ['landlines_filtered'], ['landlines_filtered']) }} as landlines_filtered,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_start'], ['texting_hours_start']) }} as texting_hours_start,
    {{ json_extract_scalar('_airbyte_data', ['is_autoassign_enabled'], ['is_autoassign_enabled']) }} as is_autoassign_enabled,
    {{ json_extract_scalar('_airbyte_data', ['messaging_service_sid'], ['messaging_service_sid']) }} as messaging_service_sid,
    {{ json_extract_scalar('_airbyte_data', ['use_dynamic_assignment'], ['use_dynamic_assignment']) }} as use_dynamic_assignment,
    {{ json_extract_scalar('_airbyte_data', ['limit_assignment_to_teams'], ['limit_assignment_to_teams']) }} as limit_assignment_to_teams,
    {{ json_extract_scalar('_airbyte_data', ['replies_stale_after_minutes'], ['replies_stale_after_minutes']) }} as replies_stale_after_minutes,
    {{ json_extract_scalar('_airbyte_data', ['autosend_limit_max_contact_id'], ['autosend_limit_max_contact_id']) }} as autosend_limit_max_contact_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_all_campaign') }} as table_alias
-- all_campaign
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

