{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_entity_connection_types_ab3') }}
select
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_connection_type_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_entity_connection_types_hashid
from {{ ref('campaigns_entity_connection_types_ab3') }}
-- campaigns_entity_connection_types from {{ source('cta', '_airbyte_raw_campaigns_entity_connection_types') }}
where 1 = 1

