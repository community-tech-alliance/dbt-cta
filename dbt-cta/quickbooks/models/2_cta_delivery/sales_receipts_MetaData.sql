select
    _airbyte_sales_receipts_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','sales_receipts_MetaData_base') }}
