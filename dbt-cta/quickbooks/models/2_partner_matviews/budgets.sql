select
    StartDate,
    SyncToken,
    Active,
    BudgetDetail,
    MetaData,
    domain,
    airbyte_cursor,
    Id,
    EndDate,
    BudgetType,
    Name,
    BudgetEntryType,
    _airbyte_emitted_at,
    _airbyte_budgets_hashid
from {{ source('cta','budgets_base') }}
