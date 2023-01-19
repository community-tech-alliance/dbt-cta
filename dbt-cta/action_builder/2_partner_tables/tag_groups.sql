select
    id,
    name,
    target_id,
    created_at,
    created_by,
    updated_at,
    target_type
from {{ source('cta','tag_groups_base') }}
