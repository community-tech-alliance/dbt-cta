select
    _airbyte_Line_hashid,
    UnitPrice,
    TaxCodeRef,
    Qty,
    ItemRef,
    _airbyte_emitted_at,
    _airbyte_SalesItemLineDetail_hashid
from {{ source('cta','sales_receipts_Line_SalesItemLineDetail_base') }}