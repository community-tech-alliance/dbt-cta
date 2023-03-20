select
    id,
    timezone,
    target_id,
    created_at,
    updated_at,
    target_type,
    created_by_id,
    deleted_by_id
from {{ source('cta','shifts_base') }}
