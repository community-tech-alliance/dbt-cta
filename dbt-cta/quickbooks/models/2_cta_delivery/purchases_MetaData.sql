select
    _airbyte_purchases_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_extracted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','purchases_MetaData_base') }}
