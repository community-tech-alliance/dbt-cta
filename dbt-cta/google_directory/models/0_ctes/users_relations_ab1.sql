-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users_ab3') }}

select
    _airbyte_users_hashid,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(relations, "$['type']") as type,
    json_extract_scalar(relations, "$['value']") as value,
    json_extract_scalar(relations, "$['customType']") as customType,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_ab3') }}
-- relations at users/relations
cross join unnest(relations) as relations
where
    1 = 1
    and relations is not null
