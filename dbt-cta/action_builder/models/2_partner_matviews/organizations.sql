select
    id,
    name,
    settings,
    subdomain,
    created_at,
    updated_at,
    api_enabled,
    country_code,
    default_country,
    administrator_user_id,
    _airbyte_organizations_hashid
from {{ source('cta','organizations_base') }}