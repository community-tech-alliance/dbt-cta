select
    CurrencyRef,
    ExchangeRate,
    TxnDate,
    airbyte_cursor,
    DepartmentRef,
    Line,
    SyncToken,
    sparse,
    TotalAmt,
    MetaData,
    domain,
    DocNumber,
    APAccountRef,
    SalesTermRef,
    Id,
    DueDate,
    VendorRef,
    Balance,
    PrivateNote,
    LinkedTxn,
    _airbyte_emitted_at,
    _airbyte_bills_hashid
from {{ source('cta','bills_base') }}