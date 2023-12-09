{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_post_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('post_insights_ab1') }}
select
    `_airbyte_extracted_at`,
    `_airbyte_post_insights_hashid`,
    `_airbyte_meta`,
    `period`,
    `values`,
    `name`,
    `description`,
    `id`,
    `title`
from {{ ref('post_insights_ab1') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
