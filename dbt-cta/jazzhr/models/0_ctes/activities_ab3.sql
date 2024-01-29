{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activities_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'date',
        'user_id',
        'action',
        'id',
        'time',
        'team_id',
        'category',
        'object_id',
    ]) }} as _airbyte_activities_hashid,
    tmp.*
from {{ ref('activities_ab2') }} tmp
-- activities
where 1 = 1

