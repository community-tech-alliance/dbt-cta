{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_schedules_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date',
        'user_type',
        'updated_at',
        'user_id',
        'minutes',
        'created_at',
        'id',
    ]) }} as _airbyte_quality_control_schedules_hashid,
    tmp.*
from {{ ref('quality_control_schedules_ab2') }} as tmp
-- quality_control_schedules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

