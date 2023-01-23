select
    id,
    name,
    type,
    locked,
    target_id,
    created_at,
    created_by,
    updated_at,
    target_type,
    tag_group_id,
    multiselectable,
    read_only_category,
    allow_create_tag_type,
    multiselect_same_tag_behavior
from {{ source('cta','tag_categories_base') }}
