select
    id,
    action_id,
    created_at,
    updated_at,
    action_entity_id,
    action_assignment_group_id
from {{ source('cta','action_assignments_base') }}
