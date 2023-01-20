select
    id,
    label,
    source,
    status,
    profile,
    entity_id,
    created_at,
    updated_at,
    created_by_id,
    updated_by_id,
    social_network_type
from {{ source('cta','social_profiles_base') }}
