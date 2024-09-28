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
-- depends_on: {{ ref('van_shifts_ab4') }}
select
    id,
    van_id,
    end_date,
    start_date,
    timeslot_id,
    committee_id,
    created_date,
    modified_date,
    sync_aggregation,
    van_event_van_id,
    event_campaign_id,
    van_event_campaign_timezone,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_van_shifts_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('van_shifts_ab4') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
