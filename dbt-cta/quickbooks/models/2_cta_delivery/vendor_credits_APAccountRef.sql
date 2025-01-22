select
    _airbyte_vendor_credits_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_APAccountRef_hashid
from {{ source('cta','vendor_credits_APAccountRef_base') }}
