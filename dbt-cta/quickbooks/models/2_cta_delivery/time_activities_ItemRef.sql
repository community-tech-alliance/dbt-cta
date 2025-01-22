select
    _airbyte_time_activities_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ItemRef_hashid
from {{ source('cta','time_activities_ItemRef_base') }}
