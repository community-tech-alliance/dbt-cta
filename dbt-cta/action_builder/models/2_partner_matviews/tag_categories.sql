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
    attachments_enabled,
    allow_create_tag_type,
    multiselect_same_tag_behavior,
    _airbyte_tag_categories_hashid
from {{ source('cta','tag_categories_base') }}