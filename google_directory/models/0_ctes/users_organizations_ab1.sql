
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(organizations, "$['name']") as name,
    json_extract_scalar(organizations, "$['title']") as title,
    json_extract_scalar(organizations, "$['primary']") as primary,
    json_extract_scalar(organizations, "$['customType']") as customType,
    json_extract_scalar(organizations, "$['description']") as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- organizations at users/organizations
cross join unnest(organizations) as organizations
where 1 = 1
and organizations is not null
