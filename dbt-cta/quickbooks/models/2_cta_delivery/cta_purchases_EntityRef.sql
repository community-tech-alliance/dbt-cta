select
    _airbyte_purchases_hashid,
    name,
    type,
    value,
    _airbyte_emitted_at,
    _airbyte_EntityRef_hashid
from {{ source('cta','purchases_EntityRef_base') }}
