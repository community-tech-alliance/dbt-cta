{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_campaigns_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'leaderboard_messages',
        'user_last_name',
        'campaign_role',
        'created_at',
        boolean_to_string('welcome_permission'),
        'team_leaderboard_reports',
        'team_rank',
        'team_leaderboard_score',
        'user_last_seen_at',
        'leaderboard_reports',
        'team_leaderboard_performs',
        'user_first_name',
        boolean_to_string('export_permission'),
        'updated_at',
        boolean_to_string('settings_permission'),
        'user_phone',
        'id',
        boolean_to_string('sync_permission'),
        'campaign_id',
        'num_contacts',
        'leaderboard_score',
        boolean_to_string('manage_users_permission'),
        'user_email',
        boolean_to_string('broadcast_permission'),
        boolean_to_string('joined'),
        'num_contacts_matched',
        'user_fullname',
        'exported_at',
        boolean_to_string('billing_permission'),
        'user_id',
        'team_leaderboard_messages',
        'leaderboard_performs',
    ]) }} as _airbyte_user_campaigns_export_hashid,
    tmp.*
from {{ ref('user_campaigns_export_ab2') }} tmp
-- user_campaigns_export
where 1 = 1

