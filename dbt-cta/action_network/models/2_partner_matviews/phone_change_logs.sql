select
    id,
    user_id,
    owner_id,
    new_phone,
    old_phone,
    created_at,
    owner_type,
    updated_at,
    source_action_id,
    source_action_type
from {{ source('cta','phone_change_logs_base') }}