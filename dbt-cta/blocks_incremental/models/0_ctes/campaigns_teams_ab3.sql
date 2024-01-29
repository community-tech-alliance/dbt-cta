{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_teams_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'team_id',
        'campaign_id',
    ]) }} as _airbyte_campaigns_teams_hashid,
    tmp.*
from {{ ref('campaigns_teams_ab2') }} as tmp
-- campaigns_teams
where 1 = 1
