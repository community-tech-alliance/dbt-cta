select
    id,
    hidden,
    user_id,
    approved,
    group_id,
    is_leader,
    created_at,
    updated_at,
    first_visit,
    join_message,
    non_inherited,
    user_permissions,
    _airbyte_groups_users_hashid
from {{ source('cta','groups_users_base') }}
