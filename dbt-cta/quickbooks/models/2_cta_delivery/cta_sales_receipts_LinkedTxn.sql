select
    _airbyte_sales_receipts_hashid,
    TxnId,
    TxnType,
    _airbyte_emitted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','sales_receipts_LinkedTxn_base') }}