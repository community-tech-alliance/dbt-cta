select
    _airbyte_classes_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_extracted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','classes_MetaData_base') }}
