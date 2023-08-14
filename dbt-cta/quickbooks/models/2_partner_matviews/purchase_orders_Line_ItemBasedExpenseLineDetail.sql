select
    _airbyte_Line_hashid,
    UnitPrice,
    ClassRef,
    TaxCodeRef,
    BillableStatus,
    Qty,
    ItemRef,
    CustomerRef,
    _airbyte_emitted_at,
    _airbyte_ItemBasedExpenseLineDetail_hashid
from {{ source('cta','purchase_orders_Line_ItemBasedExpenseLineDetail_base') }}