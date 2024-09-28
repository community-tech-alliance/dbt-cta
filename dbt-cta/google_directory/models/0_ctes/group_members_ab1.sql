-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_group_members') }}
select
    _airbyte_ab_id,
    _airbyte_emitted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract_scalar(_airbyte_data, "$['role']") as role,
    json_extract_scalar(_airbyte_data, "$['type']") as type,
    json_extract_scalar(_airbyte_data, "$['email']") as email,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_group_members') }}
where 1 = 1
