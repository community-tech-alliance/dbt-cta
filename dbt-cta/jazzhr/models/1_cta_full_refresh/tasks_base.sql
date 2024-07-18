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
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "airbyte_raw_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tasks_ab4') }}
select
    notes,
    date_due,
    owner_id,
    date_created,
    description,
    opener_name,
    object_id,
    assignee_name,
    due_whenever,
    time_created,
    id,
    status,
    assignee_id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tasks_hashid
from {{ ref('tasks_ab4') }}
-- tasks from {{ source('cta_raw', '_raw__stream_tasks') }}

{% if is_incremental() %}
where timestamp_trunc(airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}