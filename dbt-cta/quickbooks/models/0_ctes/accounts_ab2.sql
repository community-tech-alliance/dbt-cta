{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('accounts_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(CurrentBalance as {{ dbt_utils.type_float() }}) as CurrentBalance,
    cast(FullyQualifiedName as {{ dbt_utils.type_string() }}) as FullyQualifiedName,
    cast(AccountType as {{ dbt_utils.type_string() }}) as AccountType,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(ParentRef as {{ type_json() }}) as ParentRef,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(Classification as {{ dbt_utils.type_string() }}) as Classification,
    cast(CurrentBalanceWithSubAccounts as {{ dbt_utils.type_float() }}) as CurrentBalanceWithSubAccounts,
    {{ cast_to_boolean('SubAccount') }} as SubAccount,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(AcctNum as {{ dbt_utils.type_string() }}) as AcctNum,
    cast(AccountSubType as {{ dbt_utils.type_string() }}) as AccountSubType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('accounts_ab1') }}
-- accounts
where 1 = 1
