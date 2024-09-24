{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("participations_ab1") }}

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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("participations_ab1") }}
-- participations
where 1 = 1
