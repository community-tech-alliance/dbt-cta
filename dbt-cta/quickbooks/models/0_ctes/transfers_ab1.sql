{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_transfers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['ExchangeRate'], ['ExchangeRate']) }} as ExchangeRate,
    {{ json_extract('table_alias', '_airbyte_data', ['ToAccountRef'], ['ToAccountRef']) }} as ToAccountRef,
    {{ json_extract('table_alias', '_airbyte_data', ['FromAccountRef'], ['FromAccountRef']) }} as FromAccountRef,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['TxnDate'], ['TxnDate']) }} as TxnDate,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['PrivateNote'], ['PrivateNote']) }} as PrivateNote,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_transfers') }} as table_alias
-- transfers
where 1 = 1
