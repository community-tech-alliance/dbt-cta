select
    leaderboard_messages,
    user_last_name,
    campaign_role,
    created_at,
    welcome_permission,
    team_leaderboard_reports,
    team_rank,
    team_leaderboard_score,
    user_last_seen_at,
    leaderboard_reports,
    team_leaderboard_performs,
    user_first_name,
    export_permission,
    updated_at,
    settings_permission,
    user_phone,
    id,
    sync_permission,
    campaign_id,
    num_contacts,
    leaderboard_score,
    manage_users_permission,
    user_email,
    broadcast_permission,
    joined,
    num_contacts_matched,
    user_fullname,
    exported_at,
    billing_permission,
    user_id,
    team_leaderboard_messages,
    leaderboard_performs,
    _airbyte_emitted_at,
    _airbyte_user_campaigns_export_hashid
from {{ source('cta','user_campaigns_export_base') }}