{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('budgets_ab1') }}
select
    cast({{ empty_string_to_null('StartDate') }} as {{ type_timestamp_with_timezone() }}) as StartDate,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    BudgetDetail,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast({{ empty_string_to_null('EndDate') }} as {{ type_timestamp_with_timezone() }}) as EndDate,
    cast(BudgetType as {{ dbt_utils.type_string() }}) as BudgetType,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(BudgetEntryType as {{ dbt_utils.type_string() }}) as BudgetEntryType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('budgets_ab1') }}
-- budgets
where 1 = 1
