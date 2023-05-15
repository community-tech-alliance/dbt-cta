select
    _airbyte_emitted_at,
    id,
    name,
    uuid,
    notes,
    group_id,
    created_at,
    updated_at,
    parent_group_id,
    sent_to_children
from {{ source('cta','tags_base') }}