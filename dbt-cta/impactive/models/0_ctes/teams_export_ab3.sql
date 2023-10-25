{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'member_phone',
        'member_email',
        'member_user_id',
        'member_performs',
        'team_id',
        'team_rank',
        'team_leaderboard_score',
        'team_name',
        'exported_at',
        'team_leaderboard_performs',
        'member_fullname',
        'team_leader_ids',
        'campaign_id',
        'member_score',
    ]) }} as _airbyte_teams_export_hashid,
    tmp.*
from {{ ref('teams_export_ab2') }} tmp
-- teams_export
where 1 = 1

