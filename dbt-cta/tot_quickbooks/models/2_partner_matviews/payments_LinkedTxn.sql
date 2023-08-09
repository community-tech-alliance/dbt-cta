select
    _airbyte_payments_hashid,
    TxnId,
    TxnType,
    _airbyte_emitted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','payments_LinkedTxn_base') }}