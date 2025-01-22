select
    _airbyte_credit_memos_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','credit_memos_CurrencyRef_base') }}
