select
    _airbyte_Line_hashid,
    UnitPrice,
    TaxCodeRef,
    BillableStatus,
    Qty,
    ItemRef,
    _airbyte_emitted_at,
    _airbyte_ItemBasedExpenseLineDetail_hashid
from {{ source('cta','bills_Line_ItemBasedExpenseLineDetail_base') }}
