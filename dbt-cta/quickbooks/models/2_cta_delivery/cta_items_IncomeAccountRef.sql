select
    _airbyte_items_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_IncomeAccountRef_hashid
from {{ source('cta','items_IncomeAccountRef_base') }}