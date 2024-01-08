{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_teams_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'organization_id',
        'team_id',
    ]) }} as _airbyte_organizations_teams_hashid,
    tmp.*
from {{ ref('organizations_teams_ab2') }} as tmp
-- organizations_teams
where 1 = 1
