select
    _airbyte_vendor_credits_hashid,
    LineNum,
    Description,
    AccountBasedExpenseLineDetail,
    DetailType,
    Amount,
    Id,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','vendor_credits_Line_base') }}
