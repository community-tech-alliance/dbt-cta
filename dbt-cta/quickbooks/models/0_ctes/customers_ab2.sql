{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(FamilyName as {{ dbt_utils.type_string() }}) as FamilyName,
    cast(FullyQualifiedName as {{ dbt_utils.type_string() }}) as FullyQualifiedName,
    cast(GivenName as {{ dbt_utils.type_string() }}) as GivenName,
    cast(CompanyName as {{ dbt_utils.type_string() }}) as CompanyName,
    cast(ShipAddr as {{ type_json() }}) as ShipAddr,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(PaymentMethodRef as {{ type_json() }}) as PaymentMethodRef,
    {{ cast_to_boolean('BillWithParent') }} as BillWithParent,
    cast(DisplayName as {{ dbt_utils.type_string() }}) as DisplayName,
    cast(PreferredDeliveryMethod as {{ dbt_utils.type_string() }}) as PreferredDeliveryMethod,
    cast(ResaleNum as {{ dbt_utils.type_string() }}) as ResaleNum,
    {{ cast_to_boolean('Job') }} as Job,
    cast(PrimaryEmailAddr as {{ type_json() }}) as PrimaryEmailAddr,
    cast(WebAddr as {{ type_json() }}) as WebAddr,
    cast(BillAddr as {{ type_json() }}) as BillAddr,
    cast(PrimaryPhone as {{ type_json() }}) as PrimaryPhone,
    cast(PrintOnCheckName as {{ dbt_utils.type_string() }}) as PrintOnCheckName,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(MiddleName as {{ dbt_utils.type_string() }}) as MiddleName,
    cast(Mobile as {{ type_json() }}) as Mobile,
    cast(ParentRef as {{ type_json() }}) as ParentRef,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(BalanceWithJobs as {{ dbt_utils.type_float() }}) as BalanceWithJobs,
    cast(DefaultTaxCodeRef as {{ type_json() }}) as DefaultTaxCodeRef,
    cast(Level as {{ dbt_utils.type_bigint() }}) as Level,
    cast(SalesTermRef as {{ type_json() }}) as SalesTermRef,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(Fax as {{ type_json() }}) as Fax,
    cast(Balance as {{ dbt_utils.type_float() }}) as Balance,
    {{ cast_to_boolean('Taxable') }} as Taxable,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_ab1') }}
-- customers
where 1 = 1
