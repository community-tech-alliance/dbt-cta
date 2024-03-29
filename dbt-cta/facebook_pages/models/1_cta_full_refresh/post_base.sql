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
    unique_key = "_airbyte_post_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('post_ab2') }}
select
    `_airbyte_post_hashid`,
    `_airbyte_extracted_at`,
    `_airbyte_meta`,
    `sharedposts`,
    `created_time`,
    `sponsor_tags`,
    `comments`,
    `message_tags`,
    `name`,
    `reactions`,
    `id`,
    `to`,
    `message`,
    `permalink_url`,
    `actions`
from {{ ref('post_ab2') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
