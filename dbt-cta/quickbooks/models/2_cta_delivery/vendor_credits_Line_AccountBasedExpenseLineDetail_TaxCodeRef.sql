select
    _airbyte_AccountBasedExpenseLineDetail_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TaxCodeRef_hashid
from {{ source('cta','vendor_credits_Line_AccountBasedExpenseLineDetail_TaxCodeRef_base') }}
