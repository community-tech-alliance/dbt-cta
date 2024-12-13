select
    _airbyte_terms_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','terms_MetaData_base') }}
