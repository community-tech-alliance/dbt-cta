{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_assignment_group_users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'created_at',
        'updated_at',
        'end_address_id',
        'start_address_id',
        boolean_to_string('exclude_completed_actions'),
        'action_assignment_group_id',
    ]) }} as _airbyte_action_assignment_group_users_hashid,
    tmp.*
from {{ ref('action_assignment_group_users_ab2') }} as tmp
-- action_assignment_group_users
where 1 = 1
