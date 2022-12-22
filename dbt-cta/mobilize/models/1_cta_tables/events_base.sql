
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_events" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['title']") as title,
            json_extract_scalar(_airbyte_data, "$['summary']") as summary,
            json_extract_scalar(_airbyte_data, "$['owner_id']") as owner_id,
            json_extract_scalar(_airbyte_data, "$['timezone']") as timezone,
            json_extract_scalar(_airbyte_data, "$['van_name']") as van_name,
            json_extract_scalar(_airbyte_data, "$['creator_id']") as creator_id,
            json_extract_scalar(_airbyte_data, "$['event_type']") as event_type,
            json_extract_scalar(_airbyte_data, "$['is_virtual']") as is_virtual,
            json_extract_scalar(_airbyte_data, "$['visibility']") as visibility,
            json_extract_scalar(_airbyte_data, "$['browser_url']") as browser_url,
            json_extract_scalar(_airbyte_data, "$['description']") as description,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['deleted_date']") as deleted_date,
            json_extract_scalar(_airbyte_data, "$['contact__name']") as contact__name,
            json_extract_scalar(_airbyte_data, "$['high_priority']") as high_priority,
            json_extract_scalar(_airbyte_data, "$['location__lat']") as location__lat,
            json_extract_scalar(_airbyte_data, "$['location__lon']") as location__lon,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(_airbyte_data, "$['referrer__url']") as referrer__url,
            json_extract_scalar(_airbyte_data, "$['reviewed_date']") as reviewed_date,
            json_extract_scalar(_airbyte_data, "$['reviewed_by_id']") as reviewed_by_id,
            json_extract_scalar(
                _airbyte_data, "$['approval_status']"
            ) as approval_status,
            json_extract_scalar(
                _airbyte_data, "$['location__venue']"
            ) as location__venue,
            json_extract_scalar(
                _airbyte_data, "$['organization_id']"
            ) as organization_id,
            json_extract_scalar(
                _airbyte_data, "$['location__region']"
            ) as location__region,
            json_extract_scalar(
                _airbyte_data, "$['event_campaign_id']"
            ) as event_campaign_id,
            json_extract_scalar(
                _airbyte_data, "$['location__country']"
            ) as location__country,
            json_extract_scalar(
                _airbyte_data, "$['owner__given_name']"
            ) as owner__given_name,
            json_extract_scalar(
                _airbyte_data, "$['registration_mode']"
            ) as registration_mode,
            json_extract_scalar(
                _airbyte_data, "$['rejection_message']"
            ) as rejection_message,
            json_extract_scalar(
                _airbyte_data, "$['featured_image_url']"
            ) as featured_image_url,
            json_extract_scalar(
                _airbyte_data, "$['location__locality']"
            ) as location__locality,
            json_extract_scalar(
                _airbyte_data, "$['organization__name']"
            ) as organization__name,
            json_extract_scalar(
                _airbyte_data, "$['organization__slug']"
            ) as organization__slug,
            json_extract_scalar(
                _airbyte_data, "$['owner__family_name']"
            ) as owner__family_name,
            json_extract_scalar(
                _airbyte_data, "$['owner__postal_code']"
            ) as owner__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_term']"
            ) as referrer__utm_term,
            json_extract_scalar(
                _airbyte_data, "$['virtual_action_url']"
            ) as virtual_action_url,
            json_extract_scalar(
                _airbyte_data, "$['accessibility_notes']"
            ) as accessibility_notes,
            json_extract_scalar(
                _airbyte_data, "$['creator__given_name']"
            ) as creator__given_name,
            json_extract_scalar(
                _airbyte_data, "$['organization__state']"
            ) as organization__state,
            json_extract_scalar(
                _airbyte_data, "$['owner__phone_number']"
            ) as owner__phone_number,
            json_extract_scalar(
                _airbyte_data, "$['accessibility_status']"
            ) as accessibility_status,
            json_extract_scalar(
                _airbyte_data, "$['creator__family_name']"
            ) as creator__family_name,
            json_extract_scalar(
                _airbyte_data, "$['creator__postal_code']"
            ) as creator__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['event_campaign__slug']"
            ) as event_campaign__slug,
            json_extract_scalar(
                _airbyte_data, "$['location__is_private']"
            ) as location__is_private,
            json_extract_scalar(
                _airbyte_data, "$['owner__email_address']"
            ) as owner__email_address,
            json_extract_scalar(
                _airbyte_data, "$['owner__modified_date']"
            ) as owner__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_medium']"
            ) as referrer__utm_medium,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_source']"
            ) as referrer__utm_source,
            json_extract_scalar(
                _airbyte_data, "$['contact__phone_number']"
            ) as contact__phone_number,
            json_extract_scalar(
                _airbyte_data, "$['creator__phone_number']"
            ) as creator__phone_number,
            json_extract_scalar(
                _airbyte_data, "$['location__postal_code']"
            ) as location__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_content']"
            ) as referrer__utm_content,
            json_extract_scalar(
                _airbyte_data, "$['contact__email_address']"
            ) as contact__email_address,
            json_extract_scalar(
                _airbyte_data, "$['creator__email_address']"
            ) as creator__email_address,
            json_extract_scalar(
                _airbyte_data, "$['creator__modified_date']"
            ) as creator__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['organization__district']"
            ) as organization__district,
            json_extract_scalar(
                _airbyte_data, "$['referrer__utm_campaign']"
            ) as referrer__utm_campaign,
            json_extract_scalar(
                _airbyte_data, "$['location__modified_date']"
            ) as location__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['organization__race_type']"
            ) as organization__race_type,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__given_name']"
            ) as reviewed_by__given_name,
            json_extract_scalar(
                _airbyte_data, "$['location__address_line_1']"
            ) as location__address_line_1,
            json_extract_scalar(
                _airbyte_data, "$['location__address_line_2']"
            ) as location__address_line_2,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__family_name']"
            ) as reviewed_by__family_name,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__postal_code']"
            ) as reviewed_by__postal_code,
            json_extract_scalar(
                _airbyte_data, "$['created_by_volunteer_host']"
            ) as created_by_volunteer_host,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__phone_number']"
            ) as reviewed_by__phone_number,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__email_address']"
            ) as reviewed_by__email_address,
            json_extract_scalar(
                _airbyte_data, "$['reviewed_by__modified_date']"
            ) as reviewed_by__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['organization__modified_date']"
            ) as organization__modified_date,
            json_extract_scalar(
                _airbyte_data, "$['location__state_leg_district']"
            ) as location__state_leg_district,
            json_extract_scalar(
                _airbyte_data, "$['organization__candidate_name']"
            ) as organization__candidate_name,
            json_extract_scalar(
                _airbyte_data, "$['organization__is_coordinated']"
            ) as organization__is_coordinated,
            json_extract_scalar(
                _airbyte_data, "$['organization__is_independent']"
            ) as organization__is_independent,
            json_extract_scalar(
                _airbyte_data, "$['location__state_senate_district']"
            ) as location__state_senate_district,
            json_extract_scalar(
                _airbyte_data, "$['location__congressional_district']"
            ) as location__congressional_district,
            json_extract_scalar(
                _airbyte_data, "$['organization__is_primary_campaign']"
            ) as organization__is_primary_campaign,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_events") }} as table_alias
        -- events
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab1
        select
            cast(id as int64) as id,
            cast(title as string) as title,
            cast(summary as string) as summary,
            cast(owner_id as int64) as owner_id,
            cast(timezone as string) as timezone,
            cast(van_name as string) as van_name,
            cast(creator_id as int64) as creator_id,
            cast(event_type as string) as event_type,
            cast(is_virtual as boolean) as is_virtual,
            cast(visibility as string) as visibility,
            cast(browser_url as string) as browser_url,
            cast(description as string) as description,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(deleted_date, '') as timestamp) as deleted_date,
            cast(contact__name as string) as contact__name,
            cast(high_priority as boolean) as high_priority,
            cast(location__lat as float64) as location__lat,
            cast(location__lon as float64) as location__lon,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            cast(referrer__url as string) as referrer__url,
            cast(nullif(reviewed_date, '') as timestamp) as reviewed_date,
            cast(reviewed_by_id as int64) as reviewed_by_id,
            cast(approval_status as string) as approval_status,
            cast(location__venue as string) as location__venue,
            cast(organization_id as int64) as organization_id,
            cast(location__region as string) as location__region,
            cast(event_campaign_id as int64) as event_campaign_id,
            cast(location__country as string) as location__country,
            cast(owner__given_name as string) as owner__given_name,
            cast(registration_mode as string) as registration_mode,
            cast(rejection_message as string) as rejection_message,
            cast(featured_image_url as string) as featured_image_url,
            cast(location__locality as string) as location__locality,
            cast(organization__name as string) as organization__name,
            cast(organization__slug as string) as organization__slug,
            cast(owner__family_name as string) as owner__family_name,
            cast(owner__postal_code as string) as owner__postal_code,
            cast(referrer__utm_term as string) as referrer__utm_term,
            cast(virtual_action_url as string) as virtual_action_url,
            cast(accessibility_notes as string) as accessibility_notes,
            cast(creator__given_name as string) as creator__given_name,
            cast(organization__state as string) as organization__state,
            cast(owner__phone_number as string) as owner__phone_number,
            cast(accessibility_status as string) as accessibility_status,
            cast(creator__family_name as string) as creator__family_name,
            cast(creator__postal_code as string) as creator__postal_code,
            cast(event_campaign__slug as string) as event_campaign__slug,
            cast(location__is_private as boolean) as location__is_private,
            cast(owner__email_address as string) as owner__email_address,
            cast(nullif(owner__modified_date, '') as timestamp) as owner__modified_date,
            cast(referrer__utm_medium as string) as referrer__utm_medium,
            cast(referrer__utm_source as string) as referrer__utm_source,
            cast(contact__phone_number as string) as contact__phone_number,
            cast(creator__phone_number as string) as creator__phone_number,
            cast(location__postal_code as string) as location__postal_code,
            cast(referrer__utm_content as string) as referrer__utm_content,
            cast(contact__email_address as string) as contact__email_address,
            cast(creator__email_address as string) as creator__email_address,
            cast(
                nullif(creator__modified_date, '') as timestamp
            ) as creator__modified_date,
            cast(organization__district as string) as organization__district,
            cast(referrer__utm_campaign as string) as referrer__utm_campaign,
            cast(
                nullif(location__modified_date, '') as timestamp
            ) as location__modified_date,
            cast(organization__race_type as int64) as organization__race_type,
            cast(reviewed_by__given_name as string) as reviewed_by__given_name,
            cast(location__address_line_1 as string) as location__address_line_1,
            cast(location__address_line_2 as string) as location__address_line_2,
            cast(reviewed_by__family_name as string) as reviewed_by__family_name,
            cast(reviewed_by__postal_code as string) as reviewed_by__postal_code,
            cast(created_by_volunteer_host as boolean) as created_by_volunteer_host,
            cast(reviewed_by__phone_number as string) as reviewed_by__phone_number,
            cast(reviewed_by__email_address as string) as reviewed_by__email_address,
            cast(
                nullif(reviewed_by__modified_date, '') as timestamp
            ) as reviewed_by__modified_date,
            cast(
                nullif(organization__modified_date, '') as timestamp
            ) as organization__modified_date,
            cast(
                location__state_leg_district as string
            ) as location__state_leg_district,
            cast(
                organization__candidate_name as string
            ) as organization__candidate_name,
            cast(
                organization__is_coordinated as boolean
            ) as organization__is_coordinated,
            cast(
                organization__is_independent as boolean
            ) as organization__is_independent,
            cast(
                location__state_senate_district as string
            ) as location__state_senate_district,
            cast(
                location__congressional_district as string
            ) as location__congressional_district,
            cast(
                organization__is_primary_campaign as boolean
            ) as organization__is_primary_campaign,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab1
        -- events
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(title as string), ''),
                            '-',
                            coalesce(cast(summary as string), ''),
                            '-',
                            coalesce(cast(owner_id as string), ''),
                            '-',
                            coalesce(cast(timezone as string), ''),
                            '-',
                            coalesce(cast(van_name as string), ''),
                            '-',
                            coalesce(cast(creator_id as string), ''),
                            '-',
                            coalesce(cast(event_type as string), ''),
                            '-',
                            coalesce(cast(is_virtual as string), ''),
                            '-',
                            coalesce(cast(visibility as string), ''),
                            '-',
                            coalesce(cast(browser_url as string), ''),
                            '-',
                            coalesce(cast(description as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(deleted_date as string), ''),
                            '-',
                            coalesce(cast(contact__name as string), ''),
                            '-',
                            coalesce(cast(high_priority as string), ''),
                            '-',
                            coalesce(cast(location__lat as string), ''),
                            '-',
                            coalesce(cast(location__lon as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), ''),
                            '-',
                            coalesce(cast(referrer__url as string), ''),
                            '-',
                            coalesce(cast(reviewed_date as string), ''),
                            '-',
                            coalesce(cast(reviewed_by_id as string), ''),
                            '-',
                            coalesce(cast(approval_status as string), ''),
                            '-',
                            coalesce(cast(location__venue as string), ''),
                            '-',
                            coalesce(cast(organization_id as string), ''),
                            '-',
                            coalesce(cast(location__region as string), ''),
                            '-',
                            coalesce(cast(event_campaign_id as string), ''),
                            '-',
                            coalesce(cast(location__country as string), ''),
                            '-',
                            coalesce(cast(owner__given_name as string), ''),
                            '-',
                            coalesce(cast(registration_mode as string), ''),
                            '-',
                            coalesce(cast(rejection_message as string), ''),
                            '-',
                            coalesce(cast(featured_image_url as string), ''),
                            '-',
                            coalesce(cast(location__locality as string), ''),
                            '-',
                            coalesce(cast(organization__name as string), ''),
                            '-',
                            coalesce(cast(organization__slug as string), ''),
                            '-',
                            coalesce(cast(owner__family_name as string), ''),
                            '-',
                            coalesce(cast(owner__postal_code as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_term as string), ''),
                            '-',
                            coalesce(cast(virtual_action_url as string), ''),
                            '-',
                            coalesce(cast(accessibility_notes as string), ''),
                            '-',
                            coalesce(cast(creator__given_name as string), ''),
                            '-',
                            coalesce(cast(organization__state as string), ''),
                            '-',
                            coalesce(cast(owner__phone_number as string), ''),
                            '-',
                            coalesce(cast(accessibility_status as string), ''),
                            '-',
                            coalesce(cast(creator__family_name as string), ''),
                            '-',
                            coalesce(cast(creator__postal_code as string), ''),
                            '-',
                            coalesce(cast(event_campaign__slug as string), ''),
                            '-',
                            coalesce(cast(location__is_private as string), ''),
                            '-',
                            coalesce(cast(owner__email_address as string), ''),
                            '-',
                            coalesce(cast(owner__modified_date as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_medium as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_source as string), ''),
                            '-',
                            coalesce(cast(contact__phone_number as string), ''),
                            '-',
                            coalesce(cast(creator__phone_number as string), ''),
                            '-',
                            coalesce(cast(location__postal_code as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_content as string), ''),
                            '-',
                            coalesce(cast(contact__email_address as string), ''),
                            '-',
                            coalesce(cast(creator__email_address as string), ''),
                            '-',
                            coalesce(cast(creator__modified_date as string), ''),
                            '-',
                            coalesce(cast(organization__district as string), ''),
                            '-',
                            coalesce(cast(referrer__utm_campaign as string), ''),
                            '-',
                            coalesce(cast(location__modified_date as string), ''),
                            '-',
                            coalesce(cast(organization__race_type as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__given_name as string), ''),
                            '-',
                            coalesce(cast(location__address_line_1 as string), ''),
                            '-',
                            coalesce(cast(location__address_line_2 as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__family_name as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__postal_code as string), ''),
                            '-',
                            coalesce(cast(created_by_volunteer_host as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__phone_number as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__email_address as string), ''),
                            '-',
                            coalesce(cast(reviewed_by__modified_date as string), ''),
                            '-',
                            coalesce(cast(organization__modified_date as string), ''),
                            '-',
                            coalesce(cast(location__state_leg_district as string), ''),
                            '-',
                            coalesce(cast(organization__candidate_name as string), ''),
                            '-',
                            coalesce(cast(organization__is_coordinated as string), ''),
                            '-',
                            coalesce(cast(organization__is_independent as string), ''),
                            '-',
                            coalesce(
                                cast(location__state_senate_district as string), ''
                            ),
                            '-',
                            coalesce(
                                cast(location__congressional_district as string), ''
                            ),
                            '-',
                            coalesce(
                                cast(organization__is_primary_campaign as string), ''
                            )
                        ) as string
                    )
                )
            ) as _airbyte_events_hashid,
            tmp.*
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab2 tmp
        -- events
        where 1 = 1

    )  -- Final base SQL model
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab3
select
    id,
    title,
    summary,
    owner_id,
    timezone,
    van_name,
    creator_id,
    event_type,
    is_virtual,
    visibility,
    browser_url,
    description,
    created_date,
    deleted_date,
    contact__name,
    high_priority,
    location__lat,
    location__lon,
    modified_date,
    referrer__url,
    reviewed_date,
    reviewed_by_id,
    approval_status,
    location__venue,
    organization_id,
    location__region,
    event_campaign_id,
    location__country,
    owner__given_name,
    registration_mode,
    rejection_message,
    featured_image_url,
    location__locality,
    organization__name,
    organization__slug,
    owner__family_name,
    owner__postal_code,
    referrer__utm_term,
    virtual_action_url,
    accessibility_notes,
    creator__given_name,
    organization__state,
    owner__phone_number,
    accessibility_status,
    creator__family_name,
    creator__postal_code,
    event_campaign__slug,
    location__is_private,
    owner__email_address,
    owner__modified_date,
    referrer__utm_medium,
    referrer__utm_source,
    contact__phone_number,
    creator__phone_number,
    location__postal_code,
    referrer__utm_content,
    contact__email_address,
    creator__email_address,
    creator__modified_date,
    organization__district,
    referrer__utm_campaign,
    location__modified_date,
    organization__race_type,
    reviewed_by__given_name,
    location__address_line_1,
    location__address_line_2,
    reviewed_by__family_name,
    reviewed_by__postal_code,
    created_by_volunteer_host,
    reviewed_by__phone_number,
    reviewed_by__email_address,
    reviewed_by__modified_date,
    organization__modified_date,
    location__state_leg_district,
    organization__candidate_name,
    organization__is_coordinated,
    organization__is_independent,
    location__state_senate_district,
    location__congressional_district,
    organization__is_primary_campaign,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_events_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_events_ab3
-- events from {{ source("cta", "_airbyte_raw_events" ) }}
where
    1 = 1


    and cast(_airbyte_emitted_at as timestamp)
    >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)
