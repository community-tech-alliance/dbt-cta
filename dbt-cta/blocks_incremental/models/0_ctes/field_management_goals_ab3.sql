{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('field_management_goals_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'end_date',
        'turf_id',
        'id',
        'targets',
        'labels',
        'start_date',
    ]) }} as _airbyte_field_management_goals_hashid,
    tmp.*
from {{ ref('field_management_goals_ab2') }} as tmp
-- field_management_goals
where 1 = 1
