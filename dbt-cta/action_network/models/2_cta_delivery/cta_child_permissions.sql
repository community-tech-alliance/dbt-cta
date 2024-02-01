select
    id,
    group_id,
    hierarchy,
    created_at,
    updated_at,
    permissions,
    source_group_id,
    _airbyte_child_permissions_hashid
from {{ source('cta','child_permissions_base') }}
