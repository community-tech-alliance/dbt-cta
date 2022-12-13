{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('discussion_topic_ab3') }}
select
    id,
    hits,
    title,
    locked,
    sticky,
    message,
    user_id,
    forum_id,
    created_at,
    replied_by,
    stamp_type,
    updated_at,
    user_votes,
    posts_count,
    merged_topic_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_discussion_topics_hashid
from {{ ref('discussion_topic_ab3') }}
-- discussion_topics from {{ source('cta', '_airbyte_raw_discussion_topics') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

