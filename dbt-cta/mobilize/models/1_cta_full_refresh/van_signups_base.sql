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
-- depends_on: {{ ref('van_signups_ab4') }}
select
    id,
    van_id,
    user_id,
    signup_type,
    timeslot_id,
    committee_id,
    created_date,
    modified_date,
    participation_id,
    van_event_van_id,
    van_shift_van_id,
    van_person_van_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_van_signups_hashid
from {{ ref('van_signups_ab4') }}
-- van_signups from {{ source("cta", "_airbyte_raw_van_signups" ) }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}