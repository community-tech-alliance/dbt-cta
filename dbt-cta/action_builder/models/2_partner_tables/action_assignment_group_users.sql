select
    id,
    user_id,
    created_at,
    updated_at,
    end_address_id,
    start_address_id,
    exclude_completed_actions,
    action_assignment_group_id
from {{ source('cta','action_assignment_group_users_base') }}