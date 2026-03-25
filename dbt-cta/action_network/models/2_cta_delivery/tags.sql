select
    id,
    name,
    uuid,
    notes,
    hidden,
    group_id,
    created_at,
    updated_at,
    last_used_at,
    parent_group_id,
    sent_to_children,
    _airbyte_tags_hashid
from {{ source('cta','tags_base') }}
