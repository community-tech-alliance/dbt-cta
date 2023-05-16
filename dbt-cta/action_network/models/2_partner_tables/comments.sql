select
    _airbyte_emitted_at,
    id,
    title,
    content,
    user_id,
    group_id,
    parent_id,
    created_at,
    updated_at,
    user_list_id,
    commentable_id,
    commentable_type
from {{ source('cta','comments_base') }}