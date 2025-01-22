select
    _airbyte_classes_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ParentRef_hashid
from {{ source('cta','classes_ParentRef_base') }}
