select
    _airbyte_bill_payments_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','bill_payments_MetaData_base') }}
