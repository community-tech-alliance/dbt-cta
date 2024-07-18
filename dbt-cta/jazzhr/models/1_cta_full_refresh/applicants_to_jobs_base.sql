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
-- depends_on: {{ ref('applicants_to_jobs_ab4') }}
select
    date,
    applicant_id,
    job_id,
    rating,
    id,
    workflow_step_id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applicants_to_jobs_hashid
from {{ ref('applicants_to_jobs_ab4') }}
-- applicants_to_jobs from {{ source('cta_raw', '_raw__stream_applicants_to_jobs') }}

{% if is_incremental() %}
where timestamp_trunc(airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}