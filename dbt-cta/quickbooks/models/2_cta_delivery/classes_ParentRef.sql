select
    _airbyte_classes_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_ParentRef_hashid
from {{ source('cta','classes_ParentRef_base') }}
