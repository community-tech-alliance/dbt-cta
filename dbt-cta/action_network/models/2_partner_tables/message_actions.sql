select
    _airbyte_emitted_at,
    id,
    referrer,
    action_id,
    created_at,
    sending_id,
    updated_at,
    action_type,
    sending_type
from {{ source('cta','message_actions_base') }}