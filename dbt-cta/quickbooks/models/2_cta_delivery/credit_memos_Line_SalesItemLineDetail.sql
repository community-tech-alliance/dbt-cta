select
    _airbyte_Line_hashid,
    UnitPrice,
    TaxCodeRef,
    Qty,
    ItemRef,
    _airbyte_extracted_at,
    _airbyte_SalesItemLineDetail_hashid
from {{ source('cta','credit_memos_Line_SalesItemLineDetail_base') }}
