select
    _airbyte_bills_hashid,
    LineNum,
    ItemBasedExpenseLineDetail,
    Description,
    AccountBasedExpenseLineDetail,
    DetailType,
    Amount,
    Id,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','bills_Line_base') }}