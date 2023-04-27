select
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
    updated_by_id
from {{ source('cta','phone_numbers_base') }}
