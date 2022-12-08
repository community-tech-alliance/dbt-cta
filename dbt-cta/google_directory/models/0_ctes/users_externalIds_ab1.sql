-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', 'users') }}

select
    _airbyte_users_hashid,
    json_extract_scalar(externalIds, "$['type']") as type,
    json_extract_scalar(externalIds, "$['value']") as value,
    json_extract_scalar(externalIds, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ source('cta', 'users') }} as table_alias
cross join unnest(externalIds) as externalIds
where 1 = 1
and externalIds is not null