select
    id,
    name,
    uuid,
    notes,
    group_id,
    created_at,
    updated_at,
    parent_group_id,
    sent_to_children,
    _airbyte_tags_hashid
from {{ ref('tags_base') }}