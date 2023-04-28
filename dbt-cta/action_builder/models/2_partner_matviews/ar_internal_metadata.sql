select
    key,
    value,
    created_at,
    updated_at,
    _airbyte_ar_internal_metadata_hashid
from {{ source('cta','ar_internal_metadata_base') }}