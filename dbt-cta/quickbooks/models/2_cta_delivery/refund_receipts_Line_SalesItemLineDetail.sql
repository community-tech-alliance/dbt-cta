select
    _airbyte_Line_hashid,
    UnitPrice,
    TaxCodeRef,
    Qty,
    ItemRef,
    _airbyte_extracted_at,
    _airbyte_SalesItemLineDetail_hashid
from {{ source('cta','refund_receipts_Line_SalesItemLineDetail_base') }}
