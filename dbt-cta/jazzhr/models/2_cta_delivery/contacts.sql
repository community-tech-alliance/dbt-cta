select
    id,
    _airbyte_extracted_at,
    _airbyte_contacts_hashid
from {{ source('cta','contacts_base') }}
