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
-- depends_on: {{ ref('time_entries_ab2') }}
select
    id,
    agent_id,
    ticket_id,
    company_id,
    billable,
    note,
    timer_running,
    time_spent,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    SAFE_CAST(executed_at as timestamp) as executed_at,
    SAFE_CAST(start_time as timestamp) as start_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('time_entries_ab2') }}
-- time_entries from {{ source('cta', '_airbyte_raw_time_entries') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
