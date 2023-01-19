{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tasks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        boolean_to_string('resolved'),
        'created_at',
        'object_ref',
        'updated_at',
        'resolved_at',
        'resolved_by_id',
        'action_field_id',
        'action_entity_id',
    ]) }} as _airbyte_tasks_hashid,
    tmp.*
from {{ ref('tasks_ab2') }} tmp
-- tasks
where 1 = 1

