{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('time_entries_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'note',
        'agent_id',
        boolean_to_string('billable'),
        'ticket_id',
        'company_id',
        'created_at',
        'start_time',
        'time_spent',
        'updated_at',
        'executed_at',
        boolean_to_string('timer_running'),
    ]) }} as _airbyte_time_entries_hashid,
    tmp.*
from {{ ref('time_entries_ab2') }} tmp
-- time_entries
where 1 = 1

