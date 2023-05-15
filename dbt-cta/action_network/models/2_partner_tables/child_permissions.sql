select
    _airbyte_emitted_at,
    id,
    group_id,
    hierarchy,
    created_at,
    updated_at,
    permissions,
    source_group_id
from {{ source('cta','child_permissions_base') }}