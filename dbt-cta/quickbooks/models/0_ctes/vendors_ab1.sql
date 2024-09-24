{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_vendors') }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['Vendor1099'], ['Vendor1099']) }} as Vendor1099,
    {{ json_extract_scalar('_airbyte_data', ['FamilyName'], ['FamilyName']) }} as FamilyName,
    {{ json_extract_scalar('_airbyte_data', ['TaxIdentifier'], ['TaxIdentifier']) }} as TaxIdentifier,
    {{ json_extract_scalar('_airbyte_data', ['GivenName'], ['GivenName']) }} as GivenName,
    {{ json_extract_scalar('_airbyte_data', ['CompanyName'], ['CompanyName']) }} as CompanyName,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['DisplayName'], ['DisplayName']) }} as DisplayName,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryEmailAddr'], ['PrimaryEmailAddr']) }} as PrimaryEmailAddr,
    {{ json_extract_scalar('_airbyte_data', ['AcctNum'], ['AcctNum']) }} as AcctNum,
    {{ json_extract('table_alias', '_airbyte_data', ['WebAddr'], ['WebAddr']) }} as WebAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['BillAddr'], ['BillAddr']) }} as BillAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryPhone'], ['PrimaryPhone']) }} as PrimaryPhone,
    {{ json_extract_scalar('_airbyte_data', ['PrintOnCheckName'], ['PrintOnCheckName']) }} as PrintOnCheckName,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Title'], ['Title']) }} as Title,
    {{ json_extract_scalar('_airbyte_data', ['MiddleName'], ['MiddleName']) }} as MiddleName,
    {{ json_extract('table_alias', '_airbyte_data', ['Mobile'], ['Mobile']) }} as Mobile,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['Suffix'], ['Suffix']) }} as Suffix,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract('table_alias', '_airbyte_data', ['TermRef'], ['TermRef']) }} as TermRef,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract('table_alias', '_airbyte_data', ['Fax'], ['Fax']) }} as Fax,
    {{ json_extract_scalar('_airbyte_data', ['Balance'], ['Balance']) }} as Balance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_vendors') }} as table_alias
-- vendors
where 1 = 1
