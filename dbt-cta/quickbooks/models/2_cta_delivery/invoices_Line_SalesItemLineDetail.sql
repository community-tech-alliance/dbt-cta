select
    _airbyte_Line_hashid,
    UnitPrice,
    ServiceDate,
    ClassRef,
    TaxCodeRef,
    Qty,
    ItemRef,
    _airbyte_emitted_at,
    _airbyte_SalesItemLineDetail_hashid
from {{ source('cta','invoices_Line_SalesItemLineDetail_base') }}
