select
    _airbyte_emitted_at,
    id,
    ext,
    dw_id,
    number,
    source,
    status,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    interact_id,
    number_type,
    created_by_id,
    updated_by_id,
    _airbyte_phone_numbers_hashid
from {{ source('cta','phone_numbers_base') }}
