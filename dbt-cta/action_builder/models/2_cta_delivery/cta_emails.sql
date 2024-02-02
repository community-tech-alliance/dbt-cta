select
    _airbyte_emitted_at,
    id,
    email,
    source,
    status,
    owner_id,
    created_at,
    email_type,
    owner_type,
    updated_at,
    interact_id,
    created_by_id,
    updated_by_id,
    _airbyte_emails_hashid
from {{ source('cta','emails_base') }}
