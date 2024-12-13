select
    _airbyte_items_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','items_MetaData_base') }}
