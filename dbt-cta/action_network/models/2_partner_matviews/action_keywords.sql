select
    id,
    text,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type
from {{ source('cta','action_keywords_base') }}