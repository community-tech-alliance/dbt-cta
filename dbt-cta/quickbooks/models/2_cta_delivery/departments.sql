select
    ParentRef,
    SyncToken,
    Active,
    MetaData,
    domain,
    airbyte_cursor,
    FullyQualifiedName,
    SubDepartment,
    Id,
    Name,
    _airbyte_extracted_at,
    _airbyte_departments_hashid
from {{ source('cta','departments_base') }}
