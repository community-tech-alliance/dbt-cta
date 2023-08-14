select
    _airbyte_ItemBasedExpenseLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','purchase_orders_Line_ItemBasedExpenseLineDetail_CustomerRef_base') }}