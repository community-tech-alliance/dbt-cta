{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_van_locations" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
    json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
    json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- van_locations
where 1 = 1
