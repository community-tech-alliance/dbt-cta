select
    date_created,
    last_name,
    id,
    type,
    first_name,
    email,
    _airbyte_extracted_at,
    _airbyte_users_hashid
from {{ source('cta','users_base') }}
