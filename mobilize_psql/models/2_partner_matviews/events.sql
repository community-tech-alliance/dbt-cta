{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_events_hashid",
    )
}}

-- depends_on: {{ source('cta', 'events_base') }}
select
    _airbyte_events_hashid
    ,max(id) as id
    ,max(title) as title
    ,max(summary) as summary
    ,max(owner_id) as owner_id
    ,max(timezone) as timezone
    ,max(van_name) as van_name
    ,max(creator_id) as creator_id
    ,max(event_type) as event_type
    ,max(is_virtual) as is_virtual
    ,max(visibility) as visibility
    ,max(browser_url) as browser_url
    ,max(description) as description
    ,max(created_date) as created_date
    ,max(deleted_date) as deleted_date
    ,max(contact__name) as contact__name
    ,max(high_priority) as high_priority
    ,max(location__lat) as location__lat
    ,max(location__lon) as location__lon
    ,max(modified_date) as modified_date
    ,max(referrer__url) as referrer__url
    ,max(reviewed_date) as reviewed_date
    ,max(reviewed_by_id) as reviewed_by_id
    ,max(approval_status) as approval_status
    ,max(location__venue) as location__venue
    ,max(organization_id) as organization_id
    ,max(location__region) as location__region
    ,max(event_campaign_id) as event_campaign_id
    ,max(location__country) as location__country
    ,max(owner__given_name) as owner__given_name
    ,max(registration_mode) as registration_mode
    ,max(rejection_message) as rejection_message
    ,max(featured_image_url) as featured_image_url
    ,max(location__locality) as location__locality
    ,max(organization__name) as organization__name
    ,max(organization__slug) as organization__slug
    ,max(owner__family_name) as owner__family_name
    ,max(owner__postal_code) as owner__postal_code
    ,max(referrer__utm_term) as referrer__utm_term
    ,max(virtual_action_url) as virtual_action_url
    ,max(accessibility_notes) as accessibility_notes
    ,max(creator__given_name) as creator__given_name
    ,max(organization__state) as organization__state
    ,max(owner__phone_number) as owner__phone_number
    ,max(accessibility_status) as accessibility_status
    ,max(creator__family_name) as creator__family_name
    ,max(creator__postal_code) as creator__postal_code
    ,max(event_campaign__slug) as event_campaign__slug
    ,max(location__is_private) as location__is_private
    ,max(owner__email_address) as owner__email_address
    ,max(owner__modified_date) as owner__modified_date
    ,max(referrer__utm_medium) as referrer__utm_medium
    ,max(referrer__utm_source) as referrer__utm_source
    ,max(contact__phone_number) as contact__phone_number
    ,max(creator__phone_number) as creator__phone_number
    ,max(location__postal_code) as location__postal_code
    ,max(referrer__utm_content) as referrer__utm_content
    ,max(contact__email_address) as contact__email_address
    ,max(creator__email_address) as creator__email_address
    ,max(creator__modified_date) as creator__modified_date
    ,max(organization__district) as organization__district
    ,max(referrer__utm_campaign) as referrer__utm_campaign
    ,max(location__modified_date) as location__modified_date
    ,max(organization__race_type) as organization__race_type
    ,max(reviewed_by__given_name) as reviewed_by__given_name
    ,max(location__address_line_1) as location__address_line_1
    ,max(location__address_line_2) as location__address_line_2
    ,max(reviewed_by__family_name) as reviewed_by__family_name
    ,max(reviewed_by__postal_code) as reviewed_by__postal_code
    ,max(created_by_volunteer_host) as created_by_volunteer_host
    ,max(reviewed_by__phone_number) as reviewed_by__phone_number
    ,max(reviewed_by__email_address) as reviewed_by__email_address
    ,max(reviewed_by__modified_date) as reviewed_by__modified_date
    ,max(organization__modified_date) as organization__modified_date
    ,max(location__state_leg_district) as location__state_leg_district
    ,max(organization__candidate_name) as organization__candidate_name
    ,max(organization__is_coordinated) as organization__is_coordinated
    ,max(organization__is_independent) as organization__is_independent
    ,max(location__state_senate_district) as location__state_senate_district
    ,max(location__congressional_district) as location__congressional_district
    ,max(organization__is_primary_campaign) as organization__is_primary_campaign
    ,max(_airbyte_ab_id) as _airbyte_ab_id
    ,max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "events_base") }}
group by _airbyte_events_hashid
