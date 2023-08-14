select
    _airbyte_Line_hashid,
    TxnId,
    TxnType,
    TxnLineId,
    _airbyte_emitted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','deposits_Line_LinkedTxn_base') }}