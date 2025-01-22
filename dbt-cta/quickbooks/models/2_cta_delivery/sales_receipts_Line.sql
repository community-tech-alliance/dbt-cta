select
    _airbyte_sales_receipts_hashid,
    LineNum,
    DiscountLineDetail,
    Description,
    DetailType,
    Amount,
    SalesItemLineDetail,
    Id,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','sales_receipts_Line_base') }}
