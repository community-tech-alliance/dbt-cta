{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_accounts') }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['CurrentBalance'], ['CurrentBalance']) }} as CurrentBalance,
    {{ json_extract_scalar('_airbyte_data', ['FullyQualifiedName'], ['FullyQualifiedName']) }} as FullyQualifiedName,
    {{ json_extract_scalar('_airbyte_data', ['AccountType'], ['AccountType']) }} as AccountType,
    {{ json_extract_scalar('_airbyte_data', ['Name'], ['Name']) }} as Name,
    {{ json_extract('table_alias', '_airbyte_data', ['ParentRef'], ['ParentRef']) }} as ParentRef,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['Classification'], ['Classification']) }} as Classification,
    {{ json_extract_scalar('_airbyte_data', ['CurrentBalanceWithSubAccounts'], ['CurrentBalanceWithSubAccounts']) }} as CurrentBalanceWithSubAccounts,
    {{ json_extract_scalar('_airbyte_data', ['SubAccount'], ['SubAccount']) }} as SubAccount,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['AcctNum'], ['AcctNum']) }} as AcctNum,
    {{ json_extract_scalar('_airbyte_data', ['AccountSubType'], ['AccountSubType']) }} as AccountSubType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_accounts') }} as table_alias
-- accounts
where 1 = 1

