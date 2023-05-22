select
    id,
    read,
    email_id,
    group_id,
    notified,
    action_id,
    created_at,
    updated_at,
    action_type,
    syndication_id,
    _airbyte_groups_syndications_hashid
from {{ source('cta','groups_syndications_base') }}