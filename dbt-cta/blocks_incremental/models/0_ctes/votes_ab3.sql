{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('votes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'metric_id',
        'vote_weight',
        'updated_at',
        'user_id',
        boolean_to_string('vote_flag'),
        'report_id',
        'created_at',
        'id',
        'vote_scope',
    ]) }} as _airbyte_votes_hashid,
    tmp.*
from {{ ref('votes_ab2') }} as tmp
-- votes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

