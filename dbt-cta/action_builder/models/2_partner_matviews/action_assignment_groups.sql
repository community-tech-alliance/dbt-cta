select
    _airbyte_emitted_at,
    id,
    name,
    action_id,
    created_at,
    updated_at,
    assigned_to_user_id,
    _airbyte_action_assignment_groups_hashid
from {{ source('cta','action_assignment_groups_base') }}