select
    role,
    user_id,
    organization_id,
    id,
    _airbyte_extracted_at,
    _airbyte_user_organization_hashid
from {{ source('cta','user_organization_base') }}