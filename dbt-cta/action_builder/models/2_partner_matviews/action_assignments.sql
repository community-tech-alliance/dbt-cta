select
    id,
    action_id,
    created_at,
    updated_at,
    action_entity_id,
    action_assignment_group_id,
    _airbyte_action_assignments_hashid
from {{ source('cta','action_assignments_base') }}