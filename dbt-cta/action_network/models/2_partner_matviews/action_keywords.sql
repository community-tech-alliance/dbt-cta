select
    id,
    text,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    _airbyte_action_keywords_hashid
from {{ ref('action_keywords_base') }}