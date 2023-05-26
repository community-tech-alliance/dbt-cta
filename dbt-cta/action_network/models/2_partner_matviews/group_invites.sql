select
    id,
    name,
    email,
    accepted,
    group_id,
    created_at,
    inviter_id,
    updated_at,
    _airbyte_group_invites_hashid
from {{ source('cta','group_invites_base') }}