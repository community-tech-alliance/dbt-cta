select
    _airbyte_BudgetDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','budgets_BudgetDetail_AccountRef_base') }}
