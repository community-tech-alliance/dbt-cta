select
    _airbyte_tax_codes_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','tax_codes_MetaData_base') }}