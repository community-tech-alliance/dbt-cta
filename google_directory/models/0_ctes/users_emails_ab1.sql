-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', 'users') }}

select
    _airbyte_users_hashid,
    json_extract_scalar(emails, "$['type']") as type,
    json_extract_scalar(emails, "$['address']") as address,
    json_extract_scalar(emails, "$['primary']") as primary,
    json_extract_scalar(emails, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ source('cta', 'users') }} as table_alias
cross join unnest(emails) as emails
where 1 = 1
and emails is not null