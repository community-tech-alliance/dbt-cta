{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_members_assigned_locations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_team_members_hashid',
        'assignment_type',
    ]) }} as _airbyte_assigned_locations_hashid,
    tmp.*
from {{ ref('team_members_assigned_locations_ab2') }} tmp
-- assigned_locations at team_members/assigned_locations
where 1 = 1

