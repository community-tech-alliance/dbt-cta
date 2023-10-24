{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_campaigns_export_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_campaigns_export_hashid
from {{ ref('user_campaigns_export_ab3') }}
-- user_campaigns_export from {{ source('cta', '_airbyte_raw_user_campaigns_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}