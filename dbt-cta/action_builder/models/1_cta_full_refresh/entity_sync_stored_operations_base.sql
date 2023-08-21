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
-- depends_on: {{ ref('entity_sync_stored_operations_ab3') }}
select
    id,
    run_at,
    entity_id,
    operation,
    created_at,
    updated_at,
    campaign_id,
    external_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entity_sync_stored_operations_hashid
from {{ ref('entity_sync_stored_operations_ab3') }}
-- entity_sync_stored_operations from {{ source('cta', '_airbyte_raw_entity_sync_stored_operations') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
