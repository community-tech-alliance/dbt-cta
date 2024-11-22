select
    date,
    user_id,
    action,
    id,
    time,
    team_id,
    category,
    object_id,
    _airbyte_extracted_at,
    _airbyte_activities_hashid
from {{ source('cta','activities_base') }}
