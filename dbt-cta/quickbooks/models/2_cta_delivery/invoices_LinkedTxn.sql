select
    _airbyte_invoices_hashid,
    TxnId,
    TxnType,
    _airbyte_extracted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','invoices_LinkedTxn_base') }}
