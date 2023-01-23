select
    id,
    status,
    action_id,
    entity_id,
    created_at,
    updated_at,
    completed_at,
    pending_count,
    completed_count
from {{ source('cta','action_entities_base') }}
