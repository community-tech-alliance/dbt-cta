select
    _airbyte_BudgetDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_DepartmentRef_hashid
from {{ source('cta','budgets_BudgetDetail_DepartmentRef_base') }}
