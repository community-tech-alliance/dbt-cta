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
    source_action_type,
    _airbyte_phone_change_logs_hashid
from {{ ref('phone_change_logs_base') }}