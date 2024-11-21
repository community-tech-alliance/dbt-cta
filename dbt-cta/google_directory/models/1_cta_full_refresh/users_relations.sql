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
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}

-- Final base SQL model
-- depends_on: {{ ref('users_relations_ab3') }}, {{ ref('users') }}
select
    _airbyte_users_hashid,
    type,
    value,
    customType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_relations_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_relations_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


