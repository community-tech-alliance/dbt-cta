select
    id,
    created_at,
    ocdid_name,
    updated_at,
    ocdid_value,
    _airbyte_ocdids_hashid
from {{ source('cta','ocdids_base') }}