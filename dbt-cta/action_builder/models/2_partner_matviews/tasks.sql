select
    id,
    resolved,
    created_at,
    object_ref,
    updated_at,
    resolved_at,
    resolved_by_id,
    action_field_id,
    action_entity_id,
    _airbyte_tasks_hashid
from {{ source('cta','tasks_base') }}