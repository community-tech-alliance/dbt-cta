select
    _airbyte_employees_hashid,
    FreeFormNumber,
    _airbyte_emitted_at,
    _airbyte_PrimaryPhone_hashid
from {{ source('cta','employees_PrimaryPhone_base') }}
