select
    is_valid,
    created_at,
    id,
    {{ adapter.quote('hash') }},
    _airbyte_emitted_at,
    _airbyte_invite_hashid
from {{ source('cta','invite_base') }}