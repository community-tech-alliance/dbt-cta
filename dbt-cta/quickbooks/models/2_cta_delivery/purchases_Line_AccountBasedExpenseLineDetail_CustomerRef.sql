select
    _airbyte_AccountBasedExpenseLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','purchases_Line_AccountBasedExpenseLineDetail_CustomerRef_base') }}
