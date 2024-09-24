select
    _airbyte_purchases_hashid,
    ItemBasedExpenseLineDetail,
    Description,
    AccountBasedExpenseLineDetail,
    DetailType,
    Amount,
    Id,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','purchases_Line_base') }}
