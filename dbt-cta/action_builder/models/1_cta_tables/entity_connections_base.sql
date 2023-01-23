{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('entity_connections_ab3') }}
select
    id,
    status,
    imported,
    created_at,
    deleted_at,
    updated_at,
    campaign_id,
    interact_id,
    to_entity_id,
    created_by_id,
    deleted_by_id,
    updated_by_id,
    from_entity_id,
    entity_connection_type_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entity_connections_hashid
from {{ ref('entity_connections_ab3') }}
-- entity_connections from {{ source('cta', '_airbyte_raw_entity_connections') }}
where 1 = 1

