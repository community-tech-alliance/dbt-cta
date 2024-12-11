{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_van_signups" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
    json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
    json_extract_scalar(_airbyte_data, "$['signup_type']") as signup_type,
    json_extract_scalar(_airbyte_data, "$['timeslot_id']") as timeslot_id,
    json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    json_extract_scalar(_airbyte_data, "$['participation_id']") as participation_id,
    json_extract_scalar(_airbyte_data, "$['van_event_van_id']") as van_event_van_id,
    json_extract_scalar(_airbyte_data, "$['van_shift_van_id']") as van_shift_van_id,
    json_extract_scalar(_airbyte_data, "$['van_person_van_id']") as van_person_van_id,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- van_signups
where 1 = 1
