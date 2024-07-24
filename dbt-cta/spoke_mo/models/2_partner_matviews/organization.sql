select
    features,
    texting_hours_start,
    texting_hours_enforced,
    name,
    created_at,
    texting_hours_end,
    id,
    uuid,
    _airbyte_extracted_at,
    _airbyte_organization_hashid
from {{ source('cta','organization_base') }}