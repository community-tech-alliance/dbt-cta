select
    id,
    uuid,
    tag_id,
    user_id,
    group_id,
    created_at,
    updated_at,
    _airbyte_user_tags_hashid
from {{ source('cta','user_tags_base') }}
