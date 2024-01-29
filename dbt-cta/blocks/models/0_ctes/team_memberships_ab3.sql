{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_memberships_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'member_id',
        'updated_at',
        'responsibility',
        'created_at',
        'id',
        'team_id',
        'responsibility_id',
    ]) }} as _airbyte_team_memberships_hashid,
    tmp.*
from {{ ref('team_memberships_ab2') }} tmp
-- team_memberships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

