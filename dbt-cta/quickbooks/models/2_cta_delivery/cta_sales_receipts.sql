select
    CurrencyRef,
    ExchangeRate,
    EmailStatus,
    ShipAddr,
    HomeTotalAmt,
    MetaData,
    PaymentMethodRef,
    DocNumber,
    PrintStatus,
    BillEmail,
    LinkedTxn,
    BillAddr,
    PaymentRefNum,
    TxnDate,
    airbyte_cursor,
    CustomerMemo,
    Line,
    SyncToken,
    DepositToAccountRef,
    sparse,
    TotalAmt,
    domain,
    CustomField,
    Id,
    CustomerRef,
    Balance,
    ApplyTaxAfterDiscount,
    TxnTaxDetail,
    _airbyte_emitted_at,
    _airbyte_sales_receipts_hashid
from {{ source('cta','sales_receipts_base') }}