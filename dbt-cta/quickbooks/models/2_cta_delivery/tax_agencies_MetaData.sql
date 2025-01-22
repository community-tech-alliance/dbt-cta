select
    _airbyte_tax_agencies_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_extracted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','tax_agencies_MetaData_base') }}
