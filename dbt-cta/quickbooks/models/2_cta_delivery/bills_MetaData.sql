select
    _airbyte_bills_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_extracted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','bills_MetaData_base') }}
