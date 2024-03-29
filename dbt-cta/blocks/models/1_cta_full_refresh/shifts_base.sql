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
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('shifts_ab3') }}
select
    notes,
    signatures_count,
    canvasser_id,
    ready_for_delivery_at,
    visual_qc_completed_by_user_id,
    incomplete_vr_forms_count,
    absentee_ballot_request_forms_count,
    extras,
    created_at,
    soft_count_cards_total_collected,
    phone_verification_completed_by_user_id,
    type,
    field_start,
    location_id,
    shift_type,
    soft_count_pre_registration_cards_collected,
    updated_at,
    locked_at,
    locked_by_user_id,
    soft_count_cards_complete_collected,
    soft_count_cards_with_phone_collected,
    shift_end,
    id,
    campaign_id,
    digital,
    qc_external,
    ready_for_qc_at,
    soft_count_cards_with_incorrect_date_collected,
    petition_pages_count,
    ready_for_phone_verification_at,
    soft_count_cards_incomplete_collected,
    created_by_user_id,
    staging_location_id,
    tags,
    shift_start,
    completed_at,
    soft_count_cards_with_email_collected,
    field_end,
    incomplete_abr_forms_count,
    registration_forms_count,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shifts_hashid
from {{ ref('shifts_ab3') }}
-- shifts from {{ source('cta', '_airbyte_raw_shifts') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

