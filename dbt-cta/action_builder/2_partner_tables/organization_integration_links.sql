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
    organization_integration_id
from {{ source('cta','organization_integration_links_base') }}
