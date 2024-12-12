select
    CurrencyRef,
    ExchangeRate,
    TxnDate,
    airbyte_cursor,
    DepartmentRef,
    Line,
    SyncToken,
    TotalAmt,
    MetaData,
    domain,
    DocNumber,
    APAccountRef,
    Id,
    VendorRef,
    _airbyte_emitted_at,
    _airbyte_vendor_credits_hashid
from {{ source('cta','vendor_credits_base') }}
