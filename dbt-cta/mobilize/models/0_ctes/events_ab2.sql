{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("events_ab1")}}
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
    cast(nullif(creator__modified_date, '') as timestamp) as creator__modified_date,
    cast(organization__district as string) as organization__district,
    cast(referrer__utm_campaign as string) as referrer__utm_campaign,
    cast(nullif(location__modified_date, '') as timestamp) as location__modified_date,
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
    cast(location__state_leg_district as string) as location__state_leg_district,
    cast(organization__candidate_name as string) as organization__candidate_name,
    cast(organization__is_coordinated as boolean) as organization__is_coordinated,
    cast(organization__is_independent as boolean) as organization__is_independent,
    cast(location__state_senate_district as string) as location__state_senate_district,
    cast(
        location__congressional_district as string
    ) as location__congressional_district,
    cast(
        organization__is_primary_campaign as boolean
    ) as organization__is_primary_campaign,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("events_ab1")}}
-- events
where 1 = 1
