select
    SubClass,
    ParentRef,
    SyncToken,
    Active,
    MetaData,
    domain,
    airbyte_cursor,
    FullyQualifiedName,
    Id,
    Name,
    _airbyte_extracted_at,
    _airbyte_classes_hashid
from {{ source('cta','classes_base') }}
