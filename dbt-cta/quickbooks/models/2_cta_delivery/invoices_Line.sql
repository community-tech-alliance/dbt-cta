select
    _airbyte_invoices_hashid,
    LineNum,
    DiscountLineDetail,
    Description,
    DetailType,
    Amount,
    SalesItemLineDetail,
    Id,
    LinkedTxn,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','invoices_Line_base') }}
