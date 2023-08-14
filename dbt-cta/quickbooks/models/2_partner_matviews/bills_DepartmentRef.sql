select
    _airbyte_bills_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_DepartmentRef_hashid
from {{ source('cta','bills_DepartmentRef_base') }}