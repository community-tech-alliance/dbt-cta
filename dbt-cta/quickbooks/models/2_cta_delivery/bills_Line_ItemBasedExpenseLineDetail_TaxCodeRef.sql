select
    _airbyte_ItemBasedExpenseLineDetail_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TaxCodeRef_hashid
from {{ source('cta','bills_Line_ItemBasedExpenseLineDetail_TaxCodeRef_base') }}
