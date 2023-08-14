select
    _airbyte_deposits_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_DepartmentRef_hashid
from {{ source('cta','deposits_DepartmentRef_base') }}