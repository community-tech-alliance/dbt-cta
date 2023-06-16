{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('meetings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'start_time',
        'notes',
        'updated_at',
        'user_id',
        boolean_to_string('guest_attended'),
        'end_time',
        boolean_to_string('cancelled'),
        'created_at',
        'id',
        'type',
        'location_id',
        'person_id',
    ]) }} as _airbyte_meetings_hashid,
    tmp.*
from {{ ref('meetings_ab2') }} tmp
-- meetings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

