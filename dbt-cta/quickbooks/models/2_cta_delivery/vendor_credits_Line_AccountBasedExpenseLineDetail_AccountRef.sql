select
    _airbyte_AccountBasedExpenseLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','vendor_credits_Line_AccountBasedExpenseLineDetail_AccountRef_base') }}
