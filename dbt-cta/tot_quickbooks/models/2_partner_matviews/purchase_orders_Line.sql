select
    _airbyte_purchase_orders_hashid,
    LineNum,
    ItemBasedExpenseLineDetail,
    Description,
    DetailType,
    Amount,
    Id,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','purchase_orders_Line_base') }}