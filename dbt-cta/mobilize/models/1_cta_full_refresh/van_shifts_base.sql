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
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_shifts_ab3
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_van_shifts_hashid
from {{ ref('van_shifts_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}