-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users_ab3') }}

select
    _airbyte_users_hashid,
    json_extract_scalar(emails, "$['type']") as type,
    json_extract_scalar(emails, "$['address']") as address,
    json_extract_scalar(emails, "$['primary']") as primary, --noqa
    json_extract_scalar(emails, "$['customType']") as customType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ ref('users_ab3') }}
cross join unnest(emails) as emails
where 1 = 1
and emails is not null
