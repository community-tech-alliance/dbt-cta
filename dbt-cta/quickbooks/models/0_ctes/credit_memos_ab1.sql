{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_credit_memos" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['ExchangeRate'], ['ExchangeRate']) }} as ExchangeRate,
    {{ json_extract('table_alias', '_airbyte_data', ['ClassRef'], ['ClassRef']) }} as ClassRef,
    {{ json_extract_scalar('_airbyte_data', ['EmailStatus'], ['EmailStatus']) }} as EmailStatus,
    {{ json_extract('table_alias', '_airbyte_data', ['ShipAddr'], ['ShipAddr']) }} as ShipAddr,
    {{ json_extract_scalar('_airbyte_data', ['RemainingCredit'], ['RemainingCredit']) }} as RemainingCredit,
    {{ json_extract_scalar('_airbyte_data', ['HomeTotalAmt'], ['HomeTotalAmt']) }} as HomeTotalAmt,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['DocNumber'], ['DocNumber']) }} as DocNumber,
    {{ json_extract_scalar('_airbyte_data', ['PrintStatus'], ['PrintStatus']) }} as PrintStatus,
    {{ json_extract('table_alias', '_airbyte_data', ['BillEmail'], ['BillEmail']) }} as BillEmail,
    {{ json_extract('table_alias', '_airbyte_data', ['BillAddr'], ['BillAddr']) }} as BillAddr,
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
    {{ json_extract_scalar('_airbyte_data', ['Balance'], ['Balance']) }} as Balance,
    {{ json_extract_scalar('_airbyte_data', ['ApplyTaxAfterDiscount'], ['ApplyTaxAfterDiscount']) }} as ApplyTaxAfterDiscount,
    {{ json_extract('table_alias', '_airbyte_data', ['TxnTaxDetail'], ['TxnTaxDetail']) }} as TxnTaxDetail,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- credit_memos
where 1 = 1
