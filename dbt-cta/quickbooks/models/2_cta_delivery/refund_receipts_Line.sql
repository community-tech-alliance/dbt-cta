select
    _airbyte_refund_receipts_hashid,
    LineNum,
    Description,
    DetailType,
    Amount,
    SalesItemLineDetail,
    Id,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','refund_receipts_Line_base') }}
