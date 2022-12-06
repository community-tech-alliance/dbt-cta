-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', 'users') }}

select
    _airbyte_users_hashid,
    json_extract_scalar(phones, "$['type']") as type,
    json_extract_scalar(phones, "$['value']") as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ source('cta', 'users') }} as table_alias
-- phones at users/phones
cross join unnest(phones) as phones
where 1 = 1
and phones is not null