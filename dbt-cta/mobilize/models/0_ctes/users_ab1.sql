{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_users" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['given_name']") as given_name,
    json_extract_scalar(_airbyte_data, "$['family_name']") as family_name,
    json_extract_scalar(_airbyte_data, "$['postal_code']") as postal_code,
    json_extract_scalar(_airbyte_data, "$['blocked_date']") as blocked_date,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['phone_number']") as phone_number,
    json_extract_scalar(_airbyte_data, "$['email_address']") as email_address,
    json_extract_scalar(_airbyte_data, "$['membership_id']") as membership_id,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    json_extract_scalar(
        _airbyte_data, "$['globally_blocked_date']"
    ) as globally_blocked_date,
    json_extract_scalar(
        _airbyte_data, "$['membership__created_date']"
    ) as membership__created_date,
    json_extract_scalar(
        _airbyte_data, "$['membership__modified_date']"
    ) as membership__modified_date,
    json_extract_scalar(
        _airbyte_data, "$['membership__organization_id']"
    ) as membership__organization_id,
    json_extract_scalar(
        _airbyte_data, "$['membership__permission_tier']"
    ) as membership__permission_tier,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- users
where 1 = 1
