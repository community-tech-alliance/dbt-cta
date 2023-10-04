select
    _airbyte_emitted_at,
    code,
    name,
    ocd_id,
    created_at,
    updated_at,
    _airbyte_electoral_districts_hashid
from {{ source('cta','electoral_districts_base') }}
