{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_entity_types_ab3') }}
select
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_type_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_entity_types_hashid
from {{ ref('campaign_entity_types_ab3') }}
-- campaign_entity_types from {{ source('cta', '_airbyte_raw_campaign_entity_types') }}
where 1 = 1

