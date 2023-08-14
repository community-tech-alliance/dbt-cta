{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_employees') }}
select
    {{ json_extract_scalar('_airbyte_data', ['HiredDate'], ['HiredDate']) }} as HiredDate,
    {{ json_extract_scalar('_airbyte_data', ['Organization'], ['Organization']) }} as Organization,
    {{ json_extract_scalar('_airbyte_data', ['FamilyName'], ['FamilyName']) }} as FamilyName,
    {{ json_extract_scalar('_airbyte_data', ['BillableTime'], ['BillableTime']) }} as BillableTime,
    {{ json_extract_scalar('_airbyte_data', ['GivenName'], ['GivenName']) }} as GivenName,
    {{ json_extract_scalar('_airbyte_data', ['Gender'], ['Gender']) }} as Gender,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['DisplayName'], ['DisplayName']) }} as DisplayName,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryAddr'], ['PrimaryAddr']) }} as PrimaryAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryEmailAddr'], ['PrimaryEmailAddr']) }} as PrimaryEmailAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryPhone'], ['PrimaryPhone']) }} as PrimaryPhone,
    {{ json_extract_scalar('_airbyte_data', ['PrintOnCheckName'], ['PrintOnCheckName']) }} as PrintOnCheckName,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['EmployeeNumber'], ['EmployeeNumber']) }} as EmployeeNumber,
    {{ json_extract_scalar('_airbyte_data', ['Title'], ['Title']) }} as Title,
    {{ json_extract_scalar('_airbyte_data', ['MiddleName'], ['MiddleName']) }} as MiddleName,
    {{ json_extract('table_alias', '_airbyte_data', ['Mobile'], ['Mobile']) }} as Mobile,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['Suffix'], ['Suffix']) }} as Suffix,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['BillRate'], ['BillRate']) }} as BillRate,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['ReleasedDate'], ['ReleasedDate']) }} as ReleasedDate,
    {{ json_extract_scalar('_airbyte_data', ['BirthDate'], ['BirthDate']) }} as BirthDate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_employees') }} as table_alias
-- employees
where 1 = 1

