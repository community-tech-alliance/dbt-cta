select
    _airbyte_emitted_at,
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
    _airbyte_organization_integration_links_hashid
from {{ source('cta','organization_integration_links_base') }}
