select
    _airbyte_estimates_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','estimates_CustomerRef_base') }}
