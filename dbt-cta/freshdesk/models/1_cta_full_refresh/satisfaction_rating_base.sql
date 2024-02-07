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
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    partitions = partitions_to_replace,
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('satisfaction_rating_ab2') }}
select
    id,
    survey_id,
    agent_id,
    group_id,
    ticket_id,
    feedback,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    user_id as contact_id,
    ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('satisfaction_rating_ab2') }}
-- satisfaction_ratings from {{ source('cta', '_airbyte_raw_satisfaction_ratings') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


