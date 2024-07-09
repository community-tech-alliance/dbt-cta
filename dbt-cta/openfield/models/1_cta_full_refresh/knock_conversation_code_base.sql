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
    cluster_by = "_cta_loaded_at",
    partition_by = {"field": "_cta_loaded_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_knock_conversation_code_hashid"
) }}
-- Final base SQL model
-- depends_on: {{ ref('knock_conversation_code_cte2') }}
select
    id,
    code,
    created_at,
    description,
    org,
    expires,
    conversation_type,
    start_time,
    end_time,
    status,
    attempt_goal,
    reg_goal,
    vbm_goal,
    code_exhausted_email_sent,
    created_by_id,
    script_id,
    targets_id,
    max_turf_size,
    min_turf_size,
    action_text,
    action_url,
    universal_source_code,
    starting_location_id,
    skip_people_search,
    _knock_conversation_code_hashid,
    _cta_loaded_at

from {{ ref('knock_conversation_code_cte2') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_loaded_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
