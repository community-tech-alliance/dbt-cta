select
    _airbyte_bills_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_VendorRef_hashid
from {{ source('cta','bills_VendorRef_base') }}
