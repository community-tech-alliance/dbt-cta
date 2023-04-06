select
    id,
    created_at,
    ocdid_name,
    updated_at,
    ocdid_value
from {{ source('cta','ocdids_base') }}