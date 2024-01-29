{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('schedules_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'date',
        'count',
        'rule',
        'created_at',
        'schedulable_type',
        'schedulable_id',
        'updated_at',
        'until',
        adapter.quote('interval'),
        'id',
        'time',
        'day',
        'day_of_week',
    ]) }} as _airbyte_schedules_hashid,
    tmp.*
from {{ ref('schedules_ab2') }} as tmp
-- schedules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

