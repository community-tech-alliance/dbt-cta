{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('jobs_ab4') }}
select
    zip,
    maximum_salary,
    questionnaire,
    send_to_job_boards,
    notes,
    original_open_date,
    city,
    board_code,
    description,
    minimum_salary,
    team_id,
    type,
    title,
    hiring_lead,
    internal_code,
    id,
    state,
    department,
    country_id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_jobs_hashid
from {{ ref('jobs_ab4') }}
-- jobs from {{ source('cta', '_airbyte_raw_jobs') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}