
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_participations" ) }}
        select
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
            json_extract_scalar(
                _airbyte_data, "$['email_at_signup']"
            ) as email_at_signup,
            json_extract_scalar(
                _airbyte_data, "$['event_type_name']"
            ) as event_type_name,
            json_extract_scalar(
                _airbyte_data, "$['organization_id']"
            ) as organization_id,
            json_extract_scalar(
                _airbyte_data, "$['user__given_name']"
            ) as user__given_name,
            json_extract_scalar(
                _airbyte_data, "$['affiliation__name']"
            ) as affiliation__name,
            json_extract_scalar(
                _airbyte_data, "$['affiliation__slug']"
            ) as affiliation__slug,
            json_extract_scalar(
                _airbyte_data, "$['override_end_date']"
            ) as override_end_date,
            json_extract_scalar(
                _airbyte_data, "$['user__family_name']"
            ) as user__family_name,
            json_extract_scalar(
                _airbyte_data, "$['user__postal_code']"
            ) as user__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['organization__name']"
            ) as organization__name,
            json_extract_scalar(
                _airbyte_data, "$['organization__slug']"
            ) as organization__slug,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_term']"
            ) as referrer__utm_term,
            json_extract_scalar(
                _airbyte_data, "$['user__blocked_date']"
            ) as user__blocked_date,
            json_extract_scalar(
                _airbyte_data, "$['user__phone_number']"
            ) as user__phone_number,
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
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_participations") }} as table_alias
        -- participations
        where 1 = 1

    -- SQL model to cast each column to its adequate SQL type converted from the JSON
    -- schema type
    )
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab1
select
    cast(id as int64) as id,
    cast(status as string) as status,
    cast(user_id as int64) as user_id,
    cast(attended as boolean) as attended,
    cast(nullif(end_date, '') as timestamp) as end_date,
    cast(event_id as int64) as event_id,
    cast(event_type as int64) as event_type,
    cast(nullif(start_date, '') as timestamp) as start_date,
    cast(timeslot_id as int64) as timeslot_id,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    cast(referrer__url as string) as referrer__url,
    cast(affiliation_id as int64) as affiliation_id,
    cast(email_at_signup as string) as email_at_signup,
    cast(event_type_name as string) as event_type_name,
    cast(organization_id as int64) as organization_id,
    cast(user__given_name as string) as user__given_name,
    cast(affiliation__name as string) as affiliation__name,
    cast(affiliation__slug as string) as affiliation__slug,
    cast(nullif(override_end_date, '') as timestamp) as override_end_date,
    cast(user__family_name as string) as user__family_name,
    cast(user__postal_code as string) as user__postal_code,
    cast(organization__name as string) as organization__name,
    cast(organization__slug as string) as organization__slug,
    cast(referrer__utm_term as string) as referrer__utm_term,
    cast(nullif(user__blocked_date, '') as timestamp) as user__blocked_date,
    cast(user__phone_number as string) as user__phone_number,
    cast(custom_field_values as string) as custom_field_values,
    cast(nullif(override_start_date, '') as timestamp) as override_start_date,
    cast(user__email_address as string) as user__email_address,
    cast(nullif(user__modified_date, '') as timestamp) as user__modified_date,
    cast(given_name_at_signup as string) as given_name_at_signup,
    cast(referrer__utm_medium as string) as referrer__utm_medium,
    cast(referrer__utm_source as string) as referrer__utm_source,
    cast(family_name_at_signup as string) as family_name_at_signup,
    cast(postal_code_at_signup as string) as postal_code_at_signup,
    cast(referrer__utm_content as string) as referrer__utm_content,
    cast(phone_number_at_signup as string) as phone_number_at_signup,
    cast(referrer__utm_campaign as string) as referrer__utm_campaign,
    cast(experience_feedback_text as string) as experience_feedback_text,
    cast(experience_feedback_type as string) as experience_feedback_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab1
-- participations
where 1 = 1
