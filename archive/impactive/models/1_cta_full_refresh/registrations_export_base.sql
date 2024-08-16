{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('registrations_export_ab3') }}
select
    encode_id,
    has_state_identification,
    voterbase_id,
    city,
    date_of_birth,
    registration_status,
    contact_referral_full_name,
    created_at,
    team_id,
    contact_id,
    zip_code,
    unit_number,
    updated_at,
    sms_opt_in,
    different_address,
    voter_registration_status,
    activity_id,
    id,
    first_name,
    email,
    campaign_id,
    activity_title,
    referral_link,
    email_opt_in,
    address,
    completed_voter_registration_at,
    last_name,
    county_name,
    contact_referral_id,
    team_name,
    exported_at,
    state_abbrev,
    phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_registrations_export_hashid
from {{ ref('registrations_export_ab3') }}
-- registrations_export from {{ source('cta', '_airbyte_raw_registrations_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}