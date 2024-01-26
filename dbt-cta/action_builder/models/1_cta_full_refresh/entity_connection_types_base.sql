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
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('entity_connection_types_ab3') }}
select
    id,
    created_at,
    updated_at,
    interact_id,
    created_by_id,
    updated_by_id,
    display_position,
    entity_type_1_id,
    entity_type_2_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entity_connection_types_hashid
from {{ ref('entity_connection_types_ab3') }}
-- entity_connection_types from {{ source('cta', '_airbyte_raw_entity_connection_types') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
