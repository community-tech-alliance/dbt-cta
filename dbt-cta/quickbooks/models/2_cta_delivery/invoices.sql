select
    CurrencyRef,
    ExchangeRate,
    EmailStatus,
    AllowOnlineACHPayment,
    DeliveryInfo,
    AllowIPNPayment,
    ShipAddr,
    HomeTotalAmt,
    MetaData,
    DocNumber,
    PrintStatus,
    DueDate,
    BillEmail,
    PrivateNote,
    LinkedTxn,
    BillAddr,
    AllowOnlinePayment,
    TxnDate,
    airbyte_cursor,
    CustomerMemo,
    Line,
    SyncToken,
    sparse,
    TotalAmt,
    domain,
    CustomField,
    SalesTermRef,
    Id,
    CustomerRef,
    AllowOnlineCreditCardPayment,
    Balance,
    ApplyTaxAfterDiscount,
    TxnTaxDetail,
    _airbyte_extracted_at,
    _airbyte_invoices_hashid
from {{ source('cta','invoices_base') }}
