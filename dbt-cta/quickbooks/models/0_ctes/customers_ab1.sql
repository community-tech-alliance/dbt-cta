{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_customers" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract('table_alias', '_airbyte_data', ['CurrencyRef'], ['CurrencyRef']) }} as CurrencyRef,
    {{ json_extract_scalar('_airbyte_data', ['FamilyName'], ['FamilyName']) }} as FamilyName,
    {{ json_extract_scalar('_airbyte_data', ['FullyQualifiedName'], ['FullyQualifiedName']) }} as FullyQualifiedName,
    {{ json_extract_scalar('_airbyte_data', ['GivenName'], ['GivenName']) }} as GivenName,
    {{ json_extract_scalar('_airbyte_data', ['CompanyName'], ['CompanyName']) }} as CompanyName,
    {{ json_extract('table_alias', '_airbyte_data', ['ShipAddr'], ['ShipAddr']) }} as ShipAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract('table_alias', '_airbyte_data', ['PaymentMethodRef'], ['PaymentMethodRef']) }} as PaymentMethodRef,
    {{ json_extract_scalar('_airbyte_data', ['BillWithParent'], ['BillWithParent']) }} as BillWithParent,
    {{ json_extract_scalar('_airbyte_data', ['DisplayName'], ['DisplayName']) }} as DisplayName,
    {{ json_extract_scalar('_airbyte_data', ['PreferredDeliveryMethod'], ['PreferredDeliveryMethod']) }} as PreferredDeliveryMethod,
    {{ json_extract_scalar('_airbyte_data', ['ResaleNum'], ['ResaleNum']) }} as ResaleNum,
    {{ json_extract_scalar('_airbyte_data', ['Job'], ['Job']) }} as Job,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryEmailAddr'], ['PrimaryEmailAddr']) }} as PrimaryEmailAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['WebAddr'], ['WebAddr']) }} as WebAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['BillAddr'], ['BillAddr']) }} as BillAddr,
    {{ json_extract('table_alias', '_airbyte_data', ['PrimaryPhone'], ['PrimaryPhone']) }} as PrimaryPhone,
    {{ json_extract_scalar('_airbyte_data', ['PrintOnCheckName'], ['PrintOnCheckName']) }} as PrintOnCheckName,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['MiddleName'], ['MiddleName']) }} as MiddleName,
    {{ json_extract('table_alias', '_airbyte_data', ['Mobile'], ['Mobile']) }} as Mobile,
    {{ json_extract('table_alias', '_airbyte_data', ['ParentRef'], ['ParentRef']) }} as ParentRef,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['BalanceWithJobs'], ['BalanceWithJobs']) }} as BalanceWithJobs,
    {{ json_extract('table_alias', '_airbyte_data', ['DefaultTaxCodeRef'], ['DefaultTaxCodeRef']) }} as DefaultTaxCodeRef,
    {{ json_extract_scalar('_airbyte_data', ['Level'], ['Level']) }} as Level,
    {{ json_extract('table_alias', '_airbyte_data', ['SalesTermRef'], ['SalesTermRef']) }} as SalesTermRef,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract('table_alias', '_airbyte_data', ['Fax'], ['Fax']) }} as Fax,
    {{ json_extract_scalar('_airbyte_data', ['Balance'], ['Balance']) }} as Balance,
    {{ json_extract_scalar('_airbyte_data', ['Taxable'], ['Taxable']) }} as Taxable,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- customers
where 1 = 1
