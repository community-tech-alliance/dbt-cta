select
    _airbyte_AccountBasedExpenseLineDetail_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_TaxCodeRef_hashid
from {{ source('cta','bills_Line_AccountBasedExpenseLineDetail_TaxCodeRef_base') }}