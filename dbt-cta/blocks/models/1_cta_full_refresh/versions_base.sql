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
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('versions_ab3') }}
select
    item_id,
    item_type,
    object_yaml,
    created_at,
    id,
    event,
    whodunnit,
    object,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_versions_hashid
from {{ ref('versions_ab3') }}
-- versions from {{ source('cta', '_airbyte_raw_versions') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

