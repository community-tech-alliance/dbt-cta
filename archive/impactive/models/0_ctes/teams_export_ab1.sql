{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_teams_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['member_phone'], ['member_phone']) }} as member_phone,
    {{ json_extract_scalar('_airbyte_data', ['member_email'], ['member_email']) }} as member_email,
    {{ json_extract_scalar('_airbyte_data', ['member_user_id'], ['member_user_id']) }} as member_user_id,
    {{ json_extract_scalar('_airbyte_data', ['member_performs'], ['member_performs']) }} as member_performs,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['team_rank'], ['team_rank']) }} as team_rank,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_score'], ['team_leaderboard_score']) }} as team_leaderboard_score,
    {{ json_extract_scalar('_airbyte_data', ['team_name'], ['team_name']) }} as team_name,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['team_leaderboard_performs'], ['team_leaderboard_performs']) }} as team_leaderboard_performs,
    {{ json_extract_scalar('_airbyte_data', ['member_fullname'], ['member_fullname']) }} as member_fullname,
    {{ json_extract_scalar('_airbyte_data', ['team_leader_ids'], ['team_leader_ids']) }} as team_leader_ids,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['member_score'], ['member_score']) }} as member_score,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_teams_export') }} as table_alias
-- teams_export
where 1 = 1

