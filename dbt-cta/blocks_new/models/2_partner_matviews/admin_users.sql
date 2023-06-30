select
    session,
    id,
    email,
    encrypted_password,
    _airbyte_emitted_at,
    _airbyte_admin_users_hashid
from {{ source('cta','admin_users_base') }}