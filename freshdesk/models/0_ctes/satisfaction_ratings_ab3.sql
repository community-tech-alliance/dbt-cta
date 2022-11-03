{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('satisfaction_ratings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('ratings'),
        'user_id',
        'agent_id',
        'feedback',
        'group_id',
        'survey_id',
        'ticket_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_satisfaction_ratings_hashid,
    tmp.*
from {{ ref('satisfaction_ratings_ab2') }} tmp
-- satisfaction_ratings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

