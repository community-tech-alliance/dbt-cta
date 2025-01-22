select
    _airbyte_ItemBasedExpenseLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ItemRef_hashid
from {{ source('cta','purchases_Line_ItemBasedExpenseLineDetail_ItemRef_base') }}
