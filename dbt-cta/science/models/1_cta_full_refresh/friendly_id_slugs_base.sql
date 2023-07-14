
{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_friendly_id_slugs_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('friendly_id_slugs_ab3') }}
select
    sluggable_type,
    sluggable_id,
    scope,
    created_at,
    id,
    slug,
    _airbyte_friendly_id_slugs_hashid,
    _airbyte_ab_id,
    _airbyte_normalized_at,
    _airbyte_emitted_at
from {{ ref('friendly_id_slugs_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}