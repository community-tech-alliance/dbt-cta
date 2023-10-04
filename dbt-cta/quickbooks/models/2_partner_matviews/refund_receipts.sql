select
    BillAddr,
    CurrencyRef,
    ExchangeRate,
    TxnDate,
    airbyte_cursor,
    CustomerMemo,
    Line,
    SyncToken,
    DepositToAccountRef,
    sparse,
    TotalAmt,
    HomeTotalAmt,
    MetaData,
    PaymentMethodRef,
    domain,
    DocNumber,
    CustomField,
    Id,
    PrintStatus,
    CustomerRef,
    Balance,
    BillEmail,
    ApplyTaxAfterDiscount,
    TxnTaxDetail,
    _airbyte_emitted_at,
    _airbyte_refund_receipts_hashid
from {{ source('cta','refund_receipts_base') }}