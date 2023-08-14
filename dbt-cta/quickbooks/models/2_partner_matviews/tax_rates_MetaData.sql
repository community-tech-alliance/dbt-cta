select
    _airbyte_tax_rates_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','tax_rates_MetaData_base') }}