select
    zip,
    city,
    latitude,
    timezone_offset,
    state,
    has_dst,
    longitude,
    _airbyte_extracted_at,
    _airbyte_zip_code_hashid
from {{ source('cta','zip_code_base') }}