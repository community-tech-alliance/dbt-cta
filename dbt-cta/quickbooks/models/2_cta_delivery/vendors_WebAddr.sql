select
    _airbyte_vendors_hashid,
    URI,
    _airbyte_extracted_at,
    _airbyte_WebAddr_hashid
from {{ source('cta','vendors_WebAddr_base') }}
