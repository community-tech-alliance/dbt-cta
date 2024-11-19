-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users_ab3') }}
select
    _airbyte_users_hashid,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(name, "$['fullName']") as fullName,
    json_extract_scalar(name, "$['givenName']") as givenName,
    json_extract_scalar(name, "$['familyName']") as familyName,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_ab3') }}
-- name at users/name
where
    1 = 1
    and name is not null
