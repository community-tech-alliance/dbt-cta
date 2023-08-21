select
    _airbyte_emitted_at,
    id,
    status,
    action_id,
    entity_id,
    created_at,
    updated_at,
    completed_at,
    pending_count,
    completed_count,
    _airbyte_action_entities_hashid
from {{ source('cta','action_entities_base') }}
