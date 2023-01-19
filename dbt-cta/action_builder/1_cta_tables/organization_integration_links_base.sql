{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('organization_integration_links_ab3') }}
select
    id,
    settings,
    parent_id,
    created_at,
    updated_at,
    linkable_id,
    linkable_type,
    external_entity_id,
    external_entity_type,
    organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_integration_links_hashid
from {{ ref('organization_integration_links_ab3') }}
-- organization_integration_links from {{ source('cta', '_airbyte_raw_organization_integration_links') }}
where 1 = 1

