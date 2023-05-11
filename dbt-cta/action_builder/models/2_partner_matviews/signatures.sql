select
    _airbyte_emitted_at,
    id,
    text,
    created_at,
    updated_at,
    _airbyte_signatures_hashid
from {{ source('cta','signatures_base') }}