{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_events" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
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
    json_extract_scalar(_airbyte_data, "$['approval_status']") as approval_status,
    json_extract_scalar(_airbyte_data, "$['location__venue']") as location__venue,
    json_extract_scalar(_airbyte_data, "$['organization_id']") as organization_id,
    json_extract_scalar(_airbyte_data, "$['location__region']") as location__region,
    json_extract_scalar(_airbyte_data, "$['event_campaign_id']") as event_campaign_id,
    json_extract_scalar(_airbyte_data, "$['location__country']") as location__country,
    json_extract_scalar(_airbyte_data, "$['owner__given_name']") as owner__given_name,
    json_extract_scalar(_airbyte_data, "$['registration_mode']") as registration_mode,
    json_extract_scalar(_airbyte_data, "$['rejection_message']") as rejection_message,
    json_extract_scalar(_airbyte_data, "$['featured_image_url']") as featured_image_url,
    json_extract_scalar(_airbyte_data, "$['location__locality']") as location__locality,
    json_extract_scalar(_airbyte_data, "$['organization__name']") as organization__name,
    json_extract_scalar(_airbyte_data, "$['organization__slug']") as organization__slug,
    json_extract_scalar(_airbyte_data, "$['owner__family_name']") as owner__family_name,
    json_extract_scalar(_airbyte_data, "$['owner__postal_code']") as owner__postal_code,
    json_extract_scalar(_airbyte_data, "$['referrer__utm_term']") as referrer__utm_term,
    json_extract_scalar(_airbyte_data, "$['virtual_action_url']") as virtual_action_url,
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- events
where 1 = 1
