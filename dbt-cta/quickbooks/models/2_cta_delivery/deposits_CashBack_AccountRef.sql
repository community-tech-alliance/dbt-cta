select
    _airbyte_CashBack_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','deposits_CashBack_AccountRef_base') }}
