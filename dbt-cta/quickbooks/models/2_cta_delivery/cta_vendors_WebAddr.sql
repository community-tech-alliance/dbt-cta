select
    _airbyte_vendors_hashid,
    URI,
    _airbyte_emitted_at,
    _airbyte_WebAddr_hashid
from {{ source('cta','vendors_WebAddr_base') }}