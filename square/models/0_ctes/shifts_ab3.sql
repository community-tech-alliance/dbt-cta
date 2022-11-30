{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shifts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('wage'),
        array_to_string('breaks'),
        'end_at',
        'status',
        'version',
        'start_at',
        'timezone',
        'created_at',
        'updated_at',
        'employee_id',
        'location_id',
        'team_member_id',
    ]) }} as _airbyte_shifts_hashid,
    tmp.*
from {{ ref('shifts_ab2') }} tmp
-- shifts
where 1 = 1

