select
    _airbyte_time_activities_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','time_activities_MetaData_base') }}