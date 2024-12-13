select
    _airbyte_budgets_hashid,
    ClassRef,
    Amount,
    AccountRef,
    BudgetDate,
    CustomerRef,
    DepartmentRef,
    _airbyte_emitted_at,
    _airbyte_BudgetDetail_hashid
from {{ source('cta','budgets_BudgetDetail_base') }}
