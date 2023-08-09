select
    _airbyte_purchase_orders_hashid,
    TxnId,
    TxnType,
    _airbyte_emitted_at,
    _airbyte_LinkedTxn_hashid
from {{ source('cta','purchase_orders_LinkedTxn_base') }}