
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(emails, "$['type']") as type,
    json_extract_scalar(emails, "$['address']") as address,
    json_extract_scalar(emails, "$['primary']") as primary,
    json_extract_scalar(emails, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- emails at users/emails
cross join unnest(emails) as emails
where 1 = 1
and emails is not null
