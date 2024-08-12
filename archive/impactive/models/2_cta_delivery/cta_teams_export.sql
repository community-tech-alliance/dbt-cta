select
    member_phone,
    member_email,
    member_user_id,
    member_performs,
    team_id,
    team_rank,
    team_leaderboard_score,
    team_name,
    exported_at,
    team_leaderboard_performs,
    member_fullname,
    team_leader_ids,
    campaign_id,
    member_score,
    _airbyte_emitted_at,
    _airbyte_teams_export_hashid
from {{ source('cta','teams_export_base') }}