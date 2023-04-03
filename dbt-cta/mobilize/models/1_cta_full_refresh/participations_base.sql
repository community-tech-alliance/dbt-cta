{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

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

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
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
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab1
        -- participations
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(status as string), ''),
                            '-',
                            coalesce(cast(user_id as string), ''),
                            '-',
                            coalesce(cast(attended as string), ''),
                            '-',
                            coalesce(cast(end_date as string), ''),
                            '-',
                            coalesce(cast(event_id as string), ''),
                            '-',
                            coalesce(cast(event_type as string), ''),
                            '-',
                            coalesce(cast(start_date as string), ''),
                            '-',
                            coalesce(cast(timeslot_id as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), ''),
                            '-',
                            coalesce(cast(referrer__url as string), ''),
                            '-',
                            coalesce(cast(affiliation_id as string), ''),
                            '-',
                            coalesce(cast(email_at_signup as string), ''),
                            '-',
                            coalesce(cast(event_type_name as string), ''),
                            '-',
                            coalesce(cast(organization_id as string), ''),
                            '-',
                            coalesce(cast(user__given_name as string), ''),
                            '-',
                            coalesce(cast(affiliation__name as string), ''),
                            '-',
                            coalesce(cast(affiliation__slug as string), ''),
                            '-',
                            coalesce(cast(override_end_date as string), ''),
                            '-',
                            coalesce(cast(user__family_name as string), ''),
                            '-',
                            coalesce(cast(user__postal_code as string), ''),
                            '-',
                            coalesce(cast(organization__name as string), ''),
                            '-',
                            coalesce(cast(organization__slug as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_term as string), ''),
                            '-',
                            coalesce(cast(user__blocked_date as string), ''),
                            '-',
                            coalesce(cast(user__phone_number as string), ''),
                            '-',
                            coalesce(cast(custom_field_values as string), ''),
                            '-',
                            coalesce(cast(override_start_date as string), ''),
                            '-',
                            coalesce(cast(user__email_address as string), ''),
                            '-',
                            coalesce(cast(user__modified_date as string), ''),
                            '-',
                            coalesce(cast(given_name_at_signup as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_medium as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_source as string), ''),
                            '-',
                            coalesce(cast(family_name_at_signup as string), ''),
                            '-',
                            coalesce(cast(postal_code_at_signup as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_content as string), ''),
                            '-',
                            coalesce(cast(phone_number_at_signup as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_campaign as string), ''),
                            '-',
                            coalesce(cast(experience_feedback_text as string), ''),
                            '-',
                            coalesce(cast(experience_feedback_type as string), '')
                        ) as string
                    )
                )
            ) as _airbyte_participations_hashid,
            tmp.*
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab2 tmp
        -- participations
        where 1 = 1

    )  -- Final base SQL model
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab3
select
    id,
    status,
    user_id,
    attended,
    end_date,
    event_id,
    event_type,
    start_date,
    timeslot_id,
    created_date,
    modified_date,
    referrer__url,
    affiliation_id,
    email_at_signup,
    event_type_name,
    organization_id,
    user__given_name,
    affiliation__name,
    affiliation__slug,
    override_end_date,
    user__family_name,
    user__postal_code,
    organization__name,
    organization__slug,
    referrer__utm_term,
    user__blocked_date,
    user__phone_number,
    custom_field_values,
    override_start_date,
    user__email_address,
    user__modified_date,
    given_name_at_signup,
    referrer__utm_medium,
    referrer__utm_source,
    family_name_at_signup,
    postal_code_at_signup,
    referrer__utm_content,
    phone_number_at_signup,
    referrer__utm_campaign,
    experience_feedback_text,
    experience_feedback_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_participations_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_participations_ab3
-- participations from {{ source("cta", "_airbyte_raw_participations" ) }}
-- where
--     1 = 1


--     and cast(_airbyte_emitted_at as timestamp)
--     >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

-- before edits: 1500 records in base, 1500 in partner
-- after adding prefix/suffix: 