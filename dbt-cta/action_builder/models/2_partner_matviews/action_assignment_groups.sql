select
    id,
    name,
    action_id,
    created_at,
    updated_at,
    assigned_to_user_id
from {{ source('cta','action_assignment_groups_base') }}
