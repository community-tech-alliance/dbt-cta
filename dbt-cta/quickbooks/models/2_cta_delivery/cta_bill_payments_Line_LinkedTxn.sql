select
    _airbyte_Line_hashid,
    TxnId,
    TxnType,
    _airbyte_emitted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','bill_payments_Line_LinkedTxn_base') }}
