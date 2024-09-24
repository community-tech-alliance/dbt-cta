{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('employees_ab1') }}
select
    cast({{ empty_string_to_null('HiredDate') }} as {{ type_date() }}) as HiredDate,
    {{ cast_to_boolean('Organization') }} as Organization,
    cast(FamilyName as {{ dbt_utils.type_string() }}) as FamilyName,
    {{ cast_to_boolean('BillableTime') }} as BillableTime,
    cast(GivenName as {{ dbt_utils.type_string() }}) as GivenName,
    cast(Gender as {{ dbt_utils.type_string() }}) as Gender,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(DisplayName as {{ dbt_utils.type_string() }}) as DisplayName,
    cast(PrimaryAddr as {{ type_json() }}) as PrimaryAddr,
    cast(PrimaryEmailAddr as {{ type_json() }}) as PrimaryEmailAddr,
    cast(PrimaryPhone as {{ type_json() }}) as PrimaryPhone,
    cast(PrintOnCheckName as {{ dbt_utils.type_string() }}) as PrintOnCheckName,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(EmployeeNumber as {{ dbt_utils.type_string() }}) as EmployeeNumber,
    cast(Title as {{ dbt_utils.type_string() }}) as Title,
    cast(MiddleName as {{ dbt_utils.type_string() }}) as MiddleName,
    cast(Mobile as {{ type_json() }}) as Mobile,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    cast(Suffix as {{ dbt_utils.type_string() }}) as Suffix,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(BillRate as {{ dbt_utils.type_float() }}) as BillRate,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast({{ empty_string_to_null('ReleasedDate') }} as {{ type_timestamp_with_timezone() }}) as ReleasedDate,
    cast({{ empty_string_to_null('BirthDate') }} as {{ type_timestamp_with_timezone() }}) as BirthDate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('employees_ab1') }}
-- employees
where 1 = 1
