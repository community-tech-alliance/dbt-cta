select
    _airbyte_bills_hashid,
    TxnId,
    TxnType,
    _airbyte_extracted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','bills_LinkedTxn_base') }}
