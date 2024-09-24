{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_participations" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['status']") as status,
    json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
    json_extract_scalar(_airbyte_data, "$['attended']") as attended,
    json_extract_scalar(_airbyte_data, "$['end_date']") as end_date,
    json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
    json_extract_scalar(_airbyte_data, "$['event_type']") as event_type,
    json_extract_scalar(_airbyte_data, "$['start_date']") as start_date,
    json_extract_scalar(_airbyte_data, "$['timeslot_id']") as timeslot_id,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    json_extract_scalar(_airbyte_data, "$['referrer__url']") as referrer__url,
    json_extract_scalar(_airbyte_data, "$['affiliation_id']") as affiliation_id,
    json_extract_scalar(_airbyte_data, "$['email_at_signup']") as email_at_signup,
    json_extract_scalar(_airbyte_data, "$['event_type_name']") as event_type_name,
    json_extract_scalar(_airbyte_data, "$['organization_id']") as organization_id,
    json_extract_scalar(_airbyte_data, "$['user__given_name']") as user__given_name,
    json_extract_scalar(_airbyte_data, "$['affiliation__name']") as affiliation__name,
    json_extract_scalar(_airbyte_data, "$['affiliation__slug']") as affiliation__slug,
    json_extract_scalar(_airbyte_data, "$['override_end_date']") as override_end_date,
    json_extract_scalar(_airbyte_data, "$['user__family_name']") as user__family_name,
    json_extract_scalar(_airbyte_data, "$['user__postal_code']") as user__postal_code,
    json_extract_scalar(_airbyte_data, "$['organization__name']") as organization__name,
    json_extract_scalar(_airbyte_data, "$['organization__slug']") as organization__slug,
    json_extract_scalar(_airbyte_data, "$['referrer__utm_term']") as referrer__utm_term,
    json_extract_scalar(_airbyte_data, "$['user__blocked_date']") as user__blocked_date,
    json_extract_scalar(_airbyte_data, "$['user__phone_number']") as user__phone_number,
    json_extract_scalar(
        _airbyte_data, "$['custom_field_values']"
    ) as custom_field_values,
    json_extract_scalar(
        _airbyte_data, "$['override_start_date']"
    ) as override_start_date,
    json_extract_scalar(
        _airbyte_data, "$['user__email_address']"
    ) as user__email_address,
    json_extract_scalar(
        _airbyte_data, "$['user__modified_date']"
    ) as user__modified_date,
    json_extract_scalar(
        _airbyte_data, "$['given_name_at_signup']"
    ) as given_name_at_signup,
    json_extract_scalar(
        _airbyte_data, "$['referrer__utm_medium']"
    ) as referrer__utm_medium,
    json_extract_scalar(
        _airbyte_data, "$['referrer__utm_source']"
    ) as referrer__utm_source,
    json_extract_scalar(
        _airbyte_data, "$['family_name_at_signup']"
    ) as family_name_at_signup,
    json_extract_scalar(
        _airbyte_data, "$['postal_code_at_signup']"
    ) as postal_code_at_signup,
    json_extract_scalar(
        _airbyte_data, "$['referrer__utm_content']"
    ) as referrer__utm_content,
    json_extract_scalar(
        _airbyte_data, "$['phone_number_at_signup']"
    ) as phone_number_at_signup,
    json_extract_scalar(
        _airbyte_data, "$['referrer__utm_campaign']"
    ) as referrer__utm_campaign,
    json_extract_scalar(
        _airbyte_data, "$['experience_feedback_text']"
    ) as experience_feedback_text,
    json_extract_scalar(
        _airbyte_data, "$['experience_feedback_type']"
    ) as experience_feedback_type,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- participations
where 1 = 1
