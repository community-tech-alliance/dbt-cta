{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'turf_id',
        'organizer_id',
        'name',
        'creator_id',
        boolean_to_string('active'),
        'extras',
        'created_at',
        'leader_id',
        'members_count',
        'id',
        'slug',
    ]) }} as _airbyte_teams_hashid,
    tmp.*
from {{ ref('teams_ab2') }} tmp
-- teams
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

