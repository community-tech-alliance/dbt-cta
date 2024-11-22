select
    max_contacts,
    user_id,
    created_at,
    id,
    campaign_id,
    _airbyte_extracted_at,
    _airbyte_assignment_hashid
from {{ source('cta','assignment_base') }}
