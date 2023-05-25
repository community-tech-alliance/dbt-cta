select
    id,
    referrer,
    action_id,
    created_at,
    sending_id,
    updated_at,
    action_type,
    sending_type,
    _airbyte_message_actions_hashid
from {{ ref('message_actions_base') }}