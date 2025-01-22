select
    _airbyte_vendor_credits_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_extracted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','vendor_credits_MetaData_base') }}
