
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(externalIds, "$['type']") as type,
    json_extract_scalar(externalIds, "$['value']") as value,
    json_extract_scalar(externalIds, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- externalIds at users/externalIds
cross join unnest(externalIds) as externalIds
where 1 = 1
and externalIds is not null
