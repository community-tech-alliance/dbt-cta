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
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_raw_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('hires_ab4') }}
select
    hired_time,
    applicant_id,
    job_id,
    id,
    workflow_step_id,
    workflow_step_name,
    hired_date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_hires_hashid
from {{ ref('hires_ab4') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
