{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_payments" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['ExchangeRate'], ['ExchangeRate']) }} as ExchangeRate,
    {{ json_extract_scalar('_airbyte_data', ['ProcessPayment'], ['ProcessPayment']) }} as ProcessPayment,
    {{ json_extract_scalar('_airbyte_data', ['PaymentRefNum'], ['PaymentRefNum']) }} as PaymentRefNum,
    {{ json_extract_scalar('_airbyte_data', ['TxnDate'], ['TxnDate']) }} as TxnDate,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_array('_airbyte_data', ['Line'], ['Line']) }} as Line,
    {{ json_extract_scalar('_airbyte_data', ['UnappliedAmt'], ['UnappliedAmt']) }} as UnappliedAmt,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract('table_alias', '_airbyte_data', ['DepositToAccountRef'], ['DepositToAccountRef']) }} as DepositToAccountRef,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['TotalAmt'], ['TotalAmt']) }} as TotalAmt,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract('table_alias', '_airbyte_data', ['PaymentMethodRef'], ['PaymentMethodRef']) }} as PaymentMethodRef,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract('table_alias', '_airbyte_data', ['ARAccountRef'], ['ARAccountRef']) }} as ARAccountRef,
    {{ json_extract('table_alias', '_airbyte_data', ['CustomerRef'], ['CustomerRef']) }} as CustomerRef,
    {{ json_extract_scalar('_airbyte_data', ['PrivateNote'], ['PrivateNote']) }} as PrivateNote,
    {{ json_extract_array('_airbyte_data', ['LinkedTxn'], ['LinkedTxn']) }} as LinkedTxn,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- payments
where 1 = 1
