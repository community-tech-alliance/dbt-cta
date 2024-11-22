select
    _airbyte_time_activities_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','time_activities_CustomerRef_base') }}
