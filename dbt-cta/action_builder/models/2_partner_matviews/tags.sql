select
    id,
    name,
    text,
    status,
    tag_type,
    target_id,
    created_at,
    created_by,
    updated_at,
    interact_id,
    target_type,
    tag_category_id,
    _airbyte_tags_hashid
from {{ source('cta','tags_base') }}