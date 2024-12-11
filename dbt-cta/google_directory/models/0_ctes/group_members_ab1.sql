{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_group_members" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract_scalar(_airbyte_data, "$['role']") as role,
    json_extract_scalar(_airbyte_data, "$['type']") as type,
    json_extract_scalar(_airbyte_data, "$['email']") as email,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
where 1 = 1
