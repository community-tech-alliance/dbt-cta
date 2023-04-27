select
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
    updated_by_id
from {{ source('cta','emails_base') }}
