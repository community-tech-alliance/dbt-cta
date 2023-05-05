select
    id,
    label,
    source,
    status,
    profile,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    created_by_id,
    updated_by_id,
    social_network_type,
    _airbyte_social_profiles_hashid
from {{ source('cta','social_profiles_base') }}