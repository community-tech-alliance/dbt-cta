{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_shifts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'start_time',
        'event_id',
        'updated_at',
        'end_time',
        'created_at',
        'id',
    ]) }} as _airbyte_event_shifts_hashid,
    tmp.*
from {{ ref('event_shifts_ab2') }} as tmp
-- event_shifts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

