-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users_ab3') }}

select
    _airbyte_users_hashid,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(phones, "$['type']") as type,
    json_extract_scalar(phones, "$['value']") as value,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_ab3') }}
-- phones at users/phones
cross join unnest(phones) as phones
where
    1 = 1
    and phones is not null
