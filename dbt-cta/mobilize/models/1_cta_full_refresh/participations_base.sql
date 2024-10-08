{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}
{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('participations_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_participations_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('participations_ab4') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

