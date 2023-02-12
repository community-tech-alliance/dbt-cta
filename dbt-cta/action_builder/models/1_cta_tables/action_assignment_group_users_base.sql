{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_assignment_group_users_ab3') }}
select
    id,
    user_id,
    created_at,
    updated_at,
    end_address_id,
    start_address_id,
    exclude_completed_actions,
    action_assignment_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_assignment_group_users_hashid
from {{ ref('action_assignment_group_users_ab3') }}
-- action_assignment_group_users from {{ source('cta', '_airbyte_raw_action_assignment_group_users') }}
where 1 = 1
