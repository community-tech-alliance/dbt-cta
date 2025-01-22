select
    _airbyte_sales_receipts_hashid,
    Address,
    _airbyte_extracted_at,
    _airbyte_BillEmail_hashid
from {{ source('cta','sales_receipts_BillEmail_base') }}
