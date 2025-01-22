{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('budgets_BudgetDetail_ab1') }}
select
    _airbyte_budgets_hashid,
    cast(ClassRef as {{ type_json() }}) as ClassRef,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(AccountRef as {{ type_json() }}) as AccountRef,
    cast({{ empty_string_to_null('BudgetDate') }} as {{ type_timestamp_with_timezone() }}) as BudgetDate,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    cast(DepartmentRef as {{ type_json() }}) as DepartmentRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('budgets_BudgetDetail_ab1') }}
-- BudgetDetail at budgets/BudgetDetail
where 1 = 1
