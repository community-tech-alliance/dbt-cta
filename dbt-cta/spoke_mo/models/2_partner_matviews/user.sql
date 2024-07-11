select
    terms,
    extra,
    assigned_cell,
    alias,
    last_name,
    created_at,
    id,
    cell,
    auth0_id,
    is_superadmin,
    first_name,
    email,
    _airbyte_emitted_at,
    _airbyte_user_hashid
from {{ source('cta','user_base') }}