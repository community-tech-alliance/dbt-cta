select
    _airbyte_payment_methods_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','payment_methods_MetaData_base') }}