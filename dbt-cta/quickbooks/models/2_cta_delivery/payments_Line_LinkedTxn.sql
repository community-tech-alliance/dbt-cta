select
    _airbyte_Line_hashid,
    TxnId,
    TxnType,
    _airbyte_extracted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','payments_Line_LinkedTxn_base') }}
