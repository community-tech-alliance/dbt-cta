select
    id,
    text,
    created_at,
    updated_at
from {{ source('cta','signatures_base') }}
