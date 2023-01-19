select
    key,
    value,
    created_at,
    updated_at
from {{ source('cta','ar_internal_metadata_base') }}
