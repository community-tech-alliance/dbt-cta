select
    _airbyte_emitted_at,
    id,
    created_at,
    ocdid_name,
    updated_at,
    ocdid_value
from {{ source('cta','ocdids_base') }}