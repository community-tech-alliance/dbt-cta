{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_invoices') }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['ExchangeRate'], ['ExchangeRate']) }} as ExchangeRate,
    {{ json_extract_scalar('_airbyte_data', ['EmailStatus'], ['EmailStatus']) }} as EmailStatus,
    {{ json_extract_scalar('_airbyte_data', ['AllowOnlineACHPayment'], ['AllowOnlineACHPayment']) }} as AllowOnlineACHPayment,
    {{ json_extract('table_alias', '_airbyte_data', ['DeliveryInfo'], ['DeliveryInfo']) }} as DeliveryInfo,
    {{ json_extract_scalar('_airbyte_data', ['AllowIPNPayment'], ['AllowIPNPayment']) }} as AllowIPNPayment,
    {{ json_extract('table_alias', '_airbyte_data', ['ShipAddr'], ['ShipAddr']) }} as ShipAddr,
    {{ json_extract_scalar('_airbyte_data', ['HomeTotalAmt'], ['HomeTotalAmt']) }} as HomeTotalAmt,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['DocNumber'], ['DocNumber']) }} as DocNumber,
    {{ json_extract_scalar('_airbyte_data', ['PrintStatus'], ['PrintStatus']) }} as PrintStatus,
    {{ json_extract_scalar('_airbyte_data', ['DueDate'], ['DueDate']) }} as DueDate,
    {{ json_extract('table_alias', '_airbyte_data', ['BillEmail'], ['BillEmail']) }} as BillEmail,
    {{ json_extract_scalar('_airbyte_data', ['PrivateNote'], ['PrivateNote']) }} as PrivateNote,
    {{ json_extract_array('_airbyte_data', ['LinkedTxn'], ['LinkedTxn']) }} as LinkedTxn,
    {{ json_extract('table_alias', '_airbyte_data', ['BillAddr'], ['BillAddr']) }} as BillAddr,
    {{ json_extract_scalar('_airbyte_data', ['AllowOnlinePayment'], ['AllowOnlinePayment']) }} as AllowOnlinePayment,
    {{ json_extract_scalar('_airbyte_data', ['TxnDate'], ['TxnDate']) }} as TxnDate,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract('table_alias', '_airbyte_data', ['CustomerMemo'], ['CustomerMemo']) }} as CustomerMemo,
    {{ json_extract_array('_airbyte_data', ['Line'], ['Line']) }} as Line,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['TotalAmt'], ['TotalAmt']) }} as TotalAmt,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_array('_airbyte_data', ['CustomField'], ['CustomField']) }} as CustomField,
    {{ json_extract('table_alias', '_airbyte_data', ['SalesTermRef'], ['SalesTermRef']) }} as SalesTermRef,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract('table_alias', '_airbyte_data', ['CustomerRef'], ['CustomerRef']) }} as CustomerRef,
    {{ json_extract_scalar('_airbyte_data', ['AllowOnlineCreditCardPayment'], ['AllowOnlineCreditCardPayment']) }} as AllowOnlineCreditCardPayment,
    {{ json_extract_scalar('_airbyte_data', ['Balance'], ['Balance']) }} as Balance,
    {{ json_extract_scalar('_airbyte_data', ['ApplyTaxAfterDiscount'], ['ApplyTaxAfterDiscount']) }} as ApplyTaxAfterDiscount,
    {{ json_extract('table_alias', '_airbyte_data', ['TxnTaxDetail'], ['TxnTaxDetail']) }} as TxnTaxDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_invoices') }} as table_alias
-- invoices
where 1 = 1

