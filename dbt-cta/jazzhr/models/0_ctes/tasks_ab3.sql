{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tasks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'notes',
        'date_due',
        'owner_id',
        'date_created',
        'description',
        'opener_name',
        'object_id',
        'assignee_name',
        'due_whenever',
        'time_created',
        'id',
        'status',
        'assignee_id',
    ]) }} as _airbyte_tasks_hashid,
    tmp.*
from {{ ref('tasks_ab2') }} tmp
-- tasks
where 1 = 1

