select
    _airbyte_estimates_hashid,
    TxnId,
    TxnType,
    _airbyte_extracted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','estimates_LinkedTxn_base') }}
