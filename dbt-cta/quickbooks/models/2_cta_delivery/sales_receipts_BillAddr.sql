select
    _airbyte_sales_receipts_hashid,
    Line4,
    Long,
    Id,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_emitted_at,
    _airbyte_BillAddr_hashid
from {{ source('cta','sales_receipts_BillAddr_base') }}
