select
    _airbyte_refund_receipts_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','refund_receipts_MetaData_base') }}