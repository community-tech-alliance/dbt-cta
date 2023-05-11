select
    _airbyte_emitted_at,
    id,
    name,
    email,
    accepted,
    group_id,
    created_at,
    inviter_id,
    updated_at
from {{ source('cta','group_invites_base') }}