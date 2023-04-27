select
    code,
    name,
    ocd_id,
    created_at,
    updated_at
from {{ source('cta','electoral_districts_base') }}
