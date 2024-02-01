select
    _airbyte_departments_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_ParentRef_hashid
from {{ source('cta','departments_ParentRef_base') }}