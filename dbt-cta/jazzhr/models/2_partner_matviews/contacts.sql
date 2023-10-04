select
    id,
    _airbyte_emitted_at,
    _airbyte_contacts_hashid
from {{ source('cta','contacts_base') }}