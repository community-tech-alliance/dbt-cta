select
    _airbyte_vendors_hashid,
    FreeFormNumber,
    _airbyte_emitted_at,
    _airbyte_Fax_hashid
from {{ source('cta','vendors_Fax_base') }}
