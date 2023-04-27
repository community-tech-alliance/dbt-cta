{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_assignment_groups_ab3') }}
select
    id,
    name,
    action_id,
    created_at,
    updated_at,
    assigned_to_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_assignment_groups_hashid
from {{ ref('action_assignment_groups_ab3') }}
-- action_assignment_groups from {{ source('cta', '_airbyte_raw_action_assignment_groups') }}
where 1 = 1

