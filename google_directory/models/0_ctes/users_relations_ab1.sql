
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(relations, "$['type']") as type,
    json_extract_scalar(relations, "$['value']") as value,
    json_extract_scalar(relations, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- relations at users/relations
cross join unnest(relations) as relations
where 1 = 1
and relations is not null
