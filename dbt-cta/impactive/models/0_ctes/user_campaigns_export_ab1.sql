{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_user_campaigns_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['leaderboard_messages'], ['leaderboard_messages']) }} as leaderboard_messages,
    {{ json_extract_scalar('_airbyte_data', ['user_last_name'], ['user_last_name']) }} as user_last_name,
    {{ json_extract_scalar('_airbyte_data', ['campaign_role'], ['campaign_role']) }} as campaign_role,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['welcome_permission'], ['welcome_permission']) }} as welcome_permission,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_reports'], ['team_leaderboard_reports']) }} as team_leaderboard_reports,
    {{ json_extract_scalar('_airbyte_data', ['team_rank'], ['team_rank']) }} as team_rank,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_score'], ['team_leaderboard_score']) }} as team_leaderboard_score,
    {{ json_extract_scalar('_airbyte_data', ['user_last_seen_at'], ['user_last_seen_at']) }} as user_last_seen_at,
    {{ json_extract_scalar('_airbyte_data', ['leaderboard_reports'], ['leaderboard_reports']) }} as leaderboard_reports,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_performs'], ['team_leaderboard_performs']) }} as team_leaderboard_performs,
    {{ json_extract_scalar('_airbyte_data', ['user_first_name'], ['user_first_name']) }} as user_first_name,
    {{ json_extract_scalar('_airbyte_data', ['export_permission'], ['export_permission']) }} as export_permission,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['settings_permission'], ['settings_permission']) }} as settings_permission,
    {{ json_extract_scalar('_airbyte_data', ['user_phone'], ['user_phone']) }} as user_phone,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['sync_permission'], ['sync_permission']) }} as sync_permission,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['num_contacts'], ['num_contacts']) }} as num_contacts,
    {{ json_extract_scalar('_airbyte_data', ['leaderboard_score'], ['leaderboard_score']) }} as leaderboard_score,
    {{ json_extract_scalar('_airbyte_data', ['manage_users_permission'], ['manage_users_permission']) }} as manage_users_permission,
    {{ json_extract_scalar('_airbyte_data', ['user_email'], ['user_email']) }} as user_email,
    {{ json_extract_scalar('_airbyte_data', ['broadcast_permission'], ['broadcast_permission']) }} as broadcast_permission,
    {{ json_extract_scalar('_airbyte_data', ['joined'], ['joined']) }} as joined,
    {{ json_extract_scalar('_airbyte_data', ['num_contacts_matched'], ['num_contacts_matched']) }} as num_contacts_matched,
    {{ json_extract_scalar('_airbyte_data', ['user_fullname'], ['user_fullname']) }} as user_fullname,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['billing_permission'], ['billing_permission']) }} as billing_permission,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_messages'], ['team_leaderboard_messages']) }} as team_leaderboard_messages,
    {{ json_extract_scalar('_airbyte_data', ['leaderboard_performs'], ['leaderboard_performs']) }} as leaderboard_performs,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_user_campaigns_export') }} as table_alias
-- user_campaigns_export
where 1 = 1

