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
-- Final base SQL model
-- depends_on: {{ ref('events_ab3') }}
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
from {{ ref('events_ab3') }}
-- events from {{ source("cta", "_airbyte_raw_events" ) }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

