{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vendors_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    {{ cast_to_boolean('Vendor1099') }} as Vendor1099,
    cast(FamilyName as {{ dbt_utils.type_string() }}) as FamilyName,
    cast(TaxIdentifier as {{ dbt_utils.type_string() }}) as TaxIdentifier,
    cast(GivenName as {{ dbt_utils.type_string() }}) as GivenName,
    cast(CompanyName as {{ dbt_utils.type_string() }}) as CompanyName,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(DisplayName as {{ dbt_utils.type_string() }}) as DisplayName,
    cast(PrimaryEmailAddr as {{ type_json() }}) as PrimaryEmailAddr,
    cast(AcctNum as {{ dbt_utils.type_string() }}) as AcctNum,
    cast(WebAddr as {{ type_json() }}) as WebAddr,
    cast(BillAddr as {{ type_json() }}) as BillAddr,
    cast(PrimaryPhone as {{ type_json() }}) as PrimaryPhone,
    cast(PrintOnCheckName as {{ dbt_utils.type_string() }}) as PrintOnCheckName,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Title as {{ dbt_utils.type_string() }}) as Title,
    cast(MiddleName as {{ dbt_utils.type_string() }}) as MiddleName,
    cast(Mobile as {{ type_json() }}) as Mobile,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    cast(Suffix as {{ dbt_utils.type_string() }}) as Suffix,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(TermRef as {{ type_json() }}) as TermRef,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(Fax as {{ type_json() }}) as Fax,
    cast(Balance as {{ dbt_utils.type_float() }}) as Balance,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vendors_ab1') }}
-- vendors
where 1 = 1
