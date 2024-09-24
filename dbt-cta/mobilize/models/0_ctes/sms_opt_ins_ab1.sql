{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_sms_opt_ins" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    json_extract_scalar(_airbyte_data, "$['organization_id']") as organization_id,
    json_extract_scalar(_airbyte_data, "$['sms_opt_in_status']") as sms_opt_in_status,
    json_extract_scalar(_airbyte_data, "$['user__phone_number']") as user__phone_number,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- sms_opt_ins
where 1 = 1
