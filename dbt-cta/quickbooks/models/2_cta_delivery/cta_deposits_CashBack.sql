select
    _airbyte_deposits_hashid,
    Amount,
    AccountRef,
    Memo,
    _airbyte_emitted_at,
    _airbyte_CashBack_hashid
from {{ source('cta','deposits_CashBack_base') }}