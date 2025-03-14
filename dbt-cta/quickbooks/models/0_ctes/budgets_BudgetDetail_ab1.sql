{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('budgets_base') }}
{{ unnest_cte(ref('budgets_base'), 'budgets', 'BudgetDetail') }}
select
    _airbyte_budgets_hashid,
    {{ json_extract('', unnested_column_value('BudgetDetail'), ['ClassRef'], ['ClassRef']) }} as ClassRef,
    {{ json_extract_scalar(unnested_column_value('BudgetDetail'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract('', unnested_column_value('BudgetDetail'), ['AccountRef'], ['AccountRef']) }} as AccountRef,
    {{ json_extract_scalar(unnested_column_value('BudgetDetail'), ['BudgetDate'], ['BudgetDate']) }} as BudgetDate,
    {{ json_extract('', unnested_column_value('BudgetDetail'), ['CustomerRef'], ['CustomerRef']) }} as CustomerRef,
    {{ json_extract('', unnested_column_value('BudgetDetail'), ['DepartmentRef'], ['DepartmentRef']) }} as DepartmentRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('budgets_base') }}
-- BudgetDetail at budgets/BudgetDetail
{{ cross_join_unnest('budgets', 'BudgetDetail') }}
where
    1 = 1
    and BudgetDetail is not null
