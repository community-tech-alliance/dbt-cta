{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_teams_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'event_id',
        'team_id',
    ]) }} as _airbyte_events_teams_hashid,
    tmp.*
from {{ ref('events_teams_ab2') }} tmp
-- events_teams
where 1 = 1

