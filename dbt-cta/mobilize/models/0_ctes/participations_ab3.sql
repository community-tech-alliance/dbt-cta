{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref("participations_ab2") }}

select
    tmp.*,
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
    ) as _airbyte_participations_hashid
from {{ ref("participations_ab2") }} as tmp
-- participations
where 1 = 1
