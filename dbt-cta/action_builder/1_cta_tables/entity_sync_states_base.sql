{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('entity_sync_states_ab3') }}
select
    id,
    last_run,
    entity_id,
    created_at,
    updated_at,
    comparable_id,
    comparable_type,
    external_entity_id,
    external_compared_id,
    external_compared_type,
    service_integration_type,
    organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entity_sync_states_hashid
from {{ ref('entity_sync_states_ab3') }}
-- entity_sync_states from {{ source('cta', '_airbyte_raw_entity_sync_states') }}
where 1 = 1

