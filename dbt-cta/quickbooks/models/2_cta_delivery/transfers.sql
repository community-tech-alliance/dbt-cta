select
    SyncToken,
    CurrencyRef,
    ExchangeRate,
    ToAccountRef,
    FromAccountRef,
    MetaData,
    Amount,
    domain,
    TxnDate,
    airbyte_cursor,
    Id,
    PrivateNote,
    _airbyte_emitted_at,
    _airbyte_transfers_hashid
from {{ source('cta','transfers_base') }}
