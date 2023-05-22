select
    id,
    user_id,
    new_user,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code_id,
    _airbyte_user_source_codes_hashid
from {{ source('cta','user_source_codes_base') }}