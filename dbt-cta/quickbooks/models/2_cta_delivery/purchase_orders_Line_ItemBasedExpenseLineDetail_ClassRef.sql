select
    _airbyte_ItemBasedExpenseLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ClassRef_hashid
from {{ source('cta','purchase_orders_Line_ItemBasedExpenseLineDetail_ClassRef_base') }}
