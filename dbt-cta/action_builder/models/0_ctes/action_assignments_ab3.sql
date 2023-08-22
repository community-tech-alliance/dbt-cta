{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_assignments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'action_id',
        'created_at',
        'updated_at',
        'action_entity_id',
        'action_assignment_group_id',
    ]) }} as _airbyte_action_assignments_hashid,
    tmp.*
from {{ ref('action_assignments_ab2') }} as tmp
-- action_assignments
where 1 = 1
